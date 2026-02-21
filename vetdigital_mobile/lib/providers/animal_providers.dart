import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../core/network/api_client.dart';
import '../data/datasources/local/database/app_database.dart';
import '../data/datasources/remote/animal_remote_datasource.dart';
import '../data/repositories/animal_repository.dart';
import '../data/models/animal.dart';

// ─── Infrastructure providers ─────────────────────────────────────────────────

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final connectivityProvider = Provider<Connectivity>((ref) => Connectivity());

final animalRemoteDsProvider = Provider<AnimalRemoteDataSource>((ref) {
  return AnimalRemoteDataSource(ref.watch(dioProvider));
});

final animalRepositoryProvider = Provider<AnimalRepository>((ref) {
  return AnimalRepository(
    remote: ref.watch(animalRemoteDsProvider),
    db: ref.watch(appDatabaseProvider),
    connectivity: ref.watch(connectivityProvider),
  );
});

// ─── Animal list state ────────────────────────────────────────────────────────

class AnimalListState {
  final List<LocalAnimal> animals;
  final bool isLoading;
  final String? error;
  final String? selectedSpecies;
  final String? searchQuery;

  const AnimalListState({
    this.animals = const [],
    this.isLoading = false,
    this.error,
    this.selectedSpecies,
    this.searchQuery,
  });

  AnimalListState copyWith({
    List<LocalAnimal>? animals,
    bool? isLoading,
    String? error,
    String? selectedSpecies,
    String? searchQuery,
    bool clearError = false,
  }) {
    return AnimalListState(
      animals: animals ?? this.animals,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      selectedSpecies: selectedSpecies ?? this.selectedSpecies,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class AnimalListNotifier extends StateNotifier<AnimalListState> {
  final AnimalRepository _repo;

  AnimalListNotifier(this._repo) : super(const AnimalListState()) {
    load();
  }

  Future<void> load() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final animals = await _repo.getAnimals(
        species: state.selectedSpecies,
        search: state.searchQuery,
      );
      state = state.copyWith(animals: animals, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void filterBySpecies(String? species) {
    state = state.copyWith(selectedSpecies: species);
    load();
  }

  void search(String query) {
    state = state.copyWith(searchQuery: query.isEmpty ? null : query);
    load();
  }

  Future<void> refresh() => load();
}

final animalListProvider =
    StateNotifierProvider<AnimalListNotifier, AnimalListState>((ref) {
  return AnimalListNotifier(ref.watch(animalRepositoryProvider));
});

// ─── Single animal detail ─────────────────────────────────────────────────────

final animalDetailProvider =
    FutureProvider.family<AnimalModel?, String>((ref, id) async {
  return ref.watch(animalRepositoryProvider).getAnimalById(id);
});

// ─── GPS track history ────────────────────────────────────────────────────────

class TrackHistoryParams {
  final String animalId;
  final DateTime from;
  final DateTime to;
  const TrackHistoryParams(this.animalId, this.from, this.to);
}

final trackHistoryProvider =
    FutureProvider.family<List<GpsReading>, TrackHistoryParams>(
        (ref, params) async {
  final remote = ref.watch(animalRemoteDsProvider);
  return remote.getAnimalTrack(
    params.animalId,
    from: params.from,
    to: params.to,
  );
});

// ─── Sync queue count ─────────────────────────────────────────────────────────

final pendingSyncCountProvider = FutureProvider<int>((ref) async {
  return ref.watch(appDatabaseProvider).getPendingSyncCount();
});
