import 'package:connectivity_plus/connectivity_plus.dart';
import '../datasources/local/database/app_database.dart';
import '../datasources/remote/animal_remote_datasource.dart';
import '../models/animal.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

/// Animal repository: offline-first data access.
/// Reads from local Drift DB, syncs with remote API when online.
class AnimalRepository {
  final AnimalRemoteDataSource _remote;
  final AppDatabase _db;
  final Connectivity _connectivity;

  AnimalRepository({
    required AnimalRemoteDataSource remote,
    required AppDatabase db,
    required Connectivity connectivity,
  })  : _remote = remote,
        _db = db,
        _connectivity = connectivity;

  /// Get animals — tries remote first, falls back to local cache.
  Future<List<LocalAnimal>> getAnimals({
    String? species,
    String? search,
  }) async {
    final connected = await _isConnected();
    if (connected) {
      try {
        final response = await _remote.getAnimals(
          species: species,
          search: search,
          pageSize: 100,
        );
        // Cache to local DB
        for (final animal in response.items) {
          await _db.upsertAnimal(_toCompanion(animal));
        }
      } catch (_) {
        // Network failed — use cached data
      }
    }
    return _db.getAllAnimals(speciesFilter: species);
  }

  /// Get single animal — remote first with local fallback.
  Future<AnimalModel?> getAnimalById(String id) async {
    final connected = await _isConnected();
    if (connected) {
      try {
        final animal = await _remote.getAnimalById(id);
        await _db.upsertAnimal(_toCompanion(animal));
        return animal;
      } catch (_) {}
    }
    final local = await _db.getAnimalById(id);
    return local == null ? null : _fromLocalAnimal(local);
  }

  /// Create animal — saves locally first, queues for sync if offline.
  Future<AnimalModel> createAnimal(Map<String, dynamic> data) async {
    final connected = await _isConnected();
    if (connected) {
      final animal = await _remote.createAnimal(data);
      await _db.upsertAnimal(_toCompanion(animal));
      return animal;
    } else {
      // Offline: save locally with a temp ID, queue sync
      final localId = const Uuid().v4();
      final tempId = 'local-$localId';
      final companion = LocalAnimalsCompanion(
        id: Value(tempId),
        localId: Value(localId),
        identificationNo: Value(data['identification_no'] as String?),
        speciesId: Value(data['species_id'] as String?),
        sex: Value(data['sex'] as String?),
        color: Value(data['color'] as String?),
        ownerIin: Value(data['owner_iin'] as String?),
        isSynced: const Value(false),
        createdAt: Value(DateTime.now()),
        cachedAt: Value(DateTime.now()),
      );
      await _db.upsertAnimal(companion);
      await _db.addToSyncQueue(SyncQueueCompanion(
        id: Value(const Uuid().v4()),
        entityType: const Value('animal'),
        entityId: Value(tempId),
        operation: const Value('create'),
        payload: Value(data.toString()),
        createdAt: Value(DateTime.now()),
      ));
      return AnimalModel(id: tempId, localId: localId, speciesId: data['species_id'] ?? '');
    }
  }

  /// Lookup animal by RFID — remote or local search.
  Future<AnimalModel?> lookupByRfid(String rfidTagNo) async {
    final connected = await _isConnected();
    if (connected) {
      return _remote.lookupByRfid(rfidTagNo);
    }
    // Offline: search local cache
    final query = await _db.customSelect(
      'SELECT * FROM local_animals WHERE rfid_tag_no = ? AND is_deleted = 0 LIMIT 1',
      variables: [Variable.withString(rfidTagNo)],
      readsFrom: {_db.localAnimals},
    ).getSingleOrNull();
    if (query == null) return null;
    final local = await _db.getAnimalById(query.read<String>('id'));
    return local == null ? null : _fromLocalAnimal(local);
  }

  Future<bool> _isConnected() async {
    final result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  LocalAnimalsCompanion _toCompanion(AnimalModel a) {
    return LocalAnimalsCompanion(
      id: Value(a.id),
      localId: Value(a.localId),
      identificationNo: Value(a.identificationNo),
      microchipNo: Value(a.microchipNo),
      rfidTagNo: Value(a.rfidTagNo),
      speciesId: Value(a.speciesId),
      speciesName: Value(a.speciesName),
      breedName: Value(a.breedName),
      sex: Value(a.sex),
      birthDate: Value(a.birthDate),
      birthYear: Value(a.birthYear),
      color: Value(a.color),
      weightKg: Value(a.weightKg),
      status: Value(a.status ?? 'active'),
      ownerId: Value(a.ownerId),
      ownerName: Value(a.ownerName),
      ownerIin: Value(a.ownerIin),
      regionName: Value(a.regionName),
      lastLatitude: Value(a.lastLatitude),
      lastLongitude: Value(a.lastLongitude),
      lastSeenAt: Value(a.lastSeenAt),
      isSynced: const Value(true),
      cachedAt: Value(DateTime.now()),
    );
  }

  AnimalModel _fromLocalAnimal(LocalAnimal a) {
    return AnimalModel(
      id: a.id,
      localId: a.localId,
      identificationNo: a.identificationNo,
      microchipNo: a.microchipNo,
      rfidTagNo: a.rfidTagNo,
      speciesId: a.speciesId ?? '',
      speciesName: a.speciesName,
      breedName: a.breedName,
      sex: a.sex,
      birthDate: a.birthDate,
      birthYear: a.birthYear,
      color: a.color,
      weightKg: a.weightKg,
      status: a.status,
      ownerId: a.ownerId,
      ownerName: a.ownerName,
      ownerIin: a.ownerIin,
      regionName: a.regionName,
      lastLatitude: a.lastLatitude,
      lastLongitude: a.lastLongitude,
      lastSeenAt: a.lastSeenAt,
      isSynced: a.isSynced,
    );
  }
}
