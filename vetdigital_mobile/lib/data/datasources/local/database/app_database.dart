import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

// ─── Table Definitions ────────────────────────────────────────────────────────

/// Local user/session table
class LocalUsers extends Table {
  TextColumn get id => text()();
  TextColumn get iin => text()();
  TextColumn get fullName => text()();
  TextColumn get role => text()();
  TextColumn get organizationName => text().nullable()();
  TextColumn get regionName => text().nullable()();
  TextColumn get accessToken => text().nullable()();
  TextColumn get refreshToken => text().nullable()();
  DateTimeColumn get tokenExpiresAt => dateTime().nullable()();
  DateTimeColumn get lastSyncAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Offline animal cache
class LocalAnimals extends Table {
  TextColumn get id => text()();
  TextColumn get localId => text().nullable()(); // for offline-created
  TextColumn get identificationNo => text().nullable()();
  TextColumn get microchipNo => text().nullable()();
  TextColumn get rfidTagNo => text().nullable()();
  TextColumn get speciesId => text().nullable()();
  TextColumn get speciesName => text().nullable()();
  TextColumn get breedName => text().nullable()();
  TextColumn get sex => text().nullable()();
  DateTimeColumn get birthDate => dateTime().nullable()();
  IntColumn get birthYear => integer().nullable()();
  TextColumn get color => text().nullable()();
  RealColumn get weightKg => real().nullable()();
  TextColumn get status => text().withDefault(const Constant('active'))();
  TextColumn get ownerId => text().nullable()();
  TextColumn get ownerName => text().nullable()();
  TextColumn get ownerIin => text().nullable()();
  TextColumn get regionName => text().nullable()();
  RealColumn get lastLatitude => real().nullable()();
  RealColumn get lastLongitude => real().nullable()();
  DateTimeColumn get lastSeenAt => dateTime().nullable()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(true))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get cachedAt => dateTime()
      .clientDefault(() => DateTime.now())();

  @override
  Set<Column> get primaryKey => {id};
}

/// Offline procedure acts cache
class LocalProcedureActs extends Table {
  TextColumn get id => text()();
  TextColumn get localId => text().nullable()();
  TextColumn get actNumber => text()();
  DateTimeColumn get actDate => dateTime()();
  TextColumn get procedureType => text()();
  TextColumn get diseaseName => text().nullable()();
  TextColumn get settlement => text().nullable()();
  TextColumn get specialistName => text().nullable()();
  TextColumn get ownerIin => text().nullable()();
  TextColumn get ownerName => text().nullable()();
  TextColumn get speciesName => text().nullable()();
  IntColumn get maleCount => integer().nullable()();
  IntColumn get femaleCount => integer().nullable()();
  IntColumn get youngCount => integer().nullable()();
  IntColumn get totalVaccinated => integer().nullable()();
  TextColumn get vaccineName => text().nullable()();
  TextColumn get manufacturer => text().nullable()();
  TextColumn get series => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('draft'))();
  TextColumn get animalsJson => text().nullable()(); // JSON list of animals
  BoolColumn get isSynced => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get cachedAt => dateTime()
      .clientDefault(() => DateTime.now())();

  @override
  Set<Column> get primaryKey => {id};
}

/// Geofences cache
class LocalGeofences extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get geofenceType => text()();
  TextColumn get boundaryGeoJson => text()();
  TextColumn get regionName => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get cachedAt => dateTime()
      .clientDefault(() => DateTime.now())();

  @override
  Set<Column> get primaryKey => {id};
}

/// GPS readings for offline map history
class LocalGpsReadings extends Table {
  TextColumn get id => text()();
  TextColumn get deviceId => text()();
  TextColumn get animalId => text().nullable()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  RealColumn get altitude => real().nullable()();
  RealColumn get speedKmh => real().nullable()();
  RealColumn get batteryLevel => real().nullable()();
  DateTimeColumn get timestamp => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Inventory items cache
class LocalInventoryItems extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get category => text()();
  TextColumn get unit => text()();
  IntColumn get quantity => integer()();
  IntColumn get minQuantity => integer()();
  TextColumn get series => text().nullable()();
  TextColumn get expiryDate => text().nullable()();
  DateTimeColumn get cachedAt => dateTime()
      .clientDefault(() => DateTime.now())();

  @override
  Set<Column> get primaryKey => {id};
}

/// Offline sync queue — pending mutations to push when online
class SyncQueue extends Table {
  TextColumn get id => text()();
  TextColumn get entityType => text()();    // animal / procedure / owner / etc.
  TextColumn get entityId => text()();
  TextColumn get operation => text()();     // create / update / delete
  TextColumn get payload => text()();      // JSON payload
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()
      .clientDefault(() => DateTime.now())();
  DateTimeColumn get lastAttemptAt => dateTime().nullable()();
  TextColumn get errorMessage => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// ─── Database Class ───────────────────────────────────────────────────────────

@DriftDatabase(tables: [
  LocalUsers,
  LocalAnimals,
  LocalProcedureActs,
  LocalGeofences,
  LocalGpsReadings,
  LocalInventoryItems,
  SyncQueue,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    onUpgrade: (m, from, to) async {
      // Handle schema migrations here
    },
  );

  // ─── Animal queries ───────────────────────────────────────────────────────

  Future<List<LocalAnimal>> getAllAnimals({String? speciesFilter, String? searchQuery}) {
    final query = select(localAnimals)
      ..where((a) => a.isDeleted.equals(false));

    if (speciesFilter != null) {
      query.where((a) => a.speciesId.equals(speciesFilter));
    }

    return query.get();
  }

  Future<LocalAnimal?> getAnimalById(String id) {
    return (select(localAnimals)..where((a) => a.id.equals(id))).getSingleOrNull();
  }

  Future<int> upsertAnimal(LocalAnimalsCompanion animal) {
    return into(localAnimals).insertOnConflictUpdate(animal);
  }

  Future<int> softDeleteAnimal(String id) {
    return (update(localAnimals)..where((a) => a.id.equals(id)))
        .write(const LocalAnimalsCompanion(isDeleted: Value(true)));
  }

  // ─── Procedure queries ────────────────────────────────────────────────────

  Future<List<LocalProcedureAct>> getAllProcedures({String? statusFilter}) {
    final query = select(localProcedureActs);
    if (statusFilter != null) {
      query.where((p) => p.status.equals(statusFilter));
    }
    query.orderBy([(p) => OrderingTerm.desc(p.actDate)]);
    return query.get();
  }

  Future<LocalProcedureAct?> getProcedureById(String id) {
    return (select(localProcedureActs)..where((p) => p.id.equals(id))).getSingleOrNull();
  }

  Future<int> upsertProcedure(LocalProcedureActsCompanion procedure) {
    return into(localProcedureActs).insertOnConflictUpdate(procedure);
  }

  // ─── Geofence queries ─────────────────────────────────────────────────────

  Future<List<LocalGeofence>> getActiveGeofences() {
    return (select(localGeofences)..where((g) => g.isActive.equals(true))).get();
  }

  Future<int> upsertGeofence(LocalGeofencesCompanion geofence) {
    return into(localGeofences).insertOnConflictUpdate(geofence);
  }

  // ─── GPS queries ──────────────────────────────────────────────────────────

  Future<List<LocalGpsReading>> getTrackHistory({
    required String deviceId,
    required DateTime from,
    required DateTime to,
  }) {
    return (select(localGpsReadings)
          ..where((r) => r.deviceId.equals(deviceId))
          ..where((r) => r.timestamp.isBetweenValues(from, to))
          ..orderBy([(r) => OrderingTerm.asc(r.timestamp)]))
        .get();
  }

  Future<int> insertGpsReading(LocalGpsReadingsCompanion reading) {
    return into(localGpsReadings).insert(reading, mode: InsertMode.insertOrIgnore);
  }

  // ─── Inventory queries ────────────────────────────────────────────────────

  Future<List<LocalInventoryItem>> getLowStockItems() {
    return customSelect(
      'SELECT * FROM local_inventory_items WHERE quantity < min_quantity',
      readsFrom: {localInventoryItems},
    ).map((row) => LocalInventoryItem(
      id: row.read<String>('id'),
      name: row.read<String>('name'),
      category: row.read<String>('category'),
      unit: row.read<String>('unit'),
      quantity: row.read<int>('quantity'),
      minQuantity: row.read<int>('min_quantity'),
      series: row.readNullable<String>('series'),
      expiryDate: row.readNullable<String>('expiry_date'),
      cachedAt: row.read<DateTime>('cached_at'),
    )).get();
  }

  // ─── Sync queue ───────────────────────────────────────────────────────────

  Future<List<SyncQueueData>> getPendingSyncItems() {
    return (select(syncQueue)
          ..where((s) => s.retryCount.isSmallerThanValue(3))
          ..orderBy([(s) => OrderingTerm.asc(s.createdAt)]))
        .get();
  }

  Future<int> addToSyncQueue(SyncQueueCompanion item) {
    return into(syncQueue).insert(item);
  }

  Future<int> removeSyncQueueItem(String id) {
    return (delete(syncQueue)..where((s) => s.id.equals(id))).go();
  }

  Future<void> incrementRetryCount(String id) async {
    await customUpdate(
      'UPDATE sync_queue SET retry_count = retry_count + 1, last_attempt_at = ? WHERE id = ?',
      variables: [Variable.withDateTime(DateTime.now()), Variable.withString(id)],
      updates: {syncQueue},
    );
  }

  Future<int> getPendingSyncCount() async {
    final result = await customSelect(
      'SELECT COUNT(*) as count FROM sync_queue WHERE retry_count < 3',
      readsFrom: {syncQueue},
    ).getSingle();
    return result.read<int>('count');
  }
}

// ─── Database connection ──────────────────────────────────────────────────────

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'vetdigital.db'));
    return NativeDatabase.createInBackground(file);
  });
}
