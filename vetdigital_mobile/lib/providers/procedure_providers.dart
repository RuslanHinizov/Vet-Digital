import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/network/api_client.dart';
import '../data/datasources/remote/procedure_remote_datasource.dart';
import '../data/models/procedure.dart';

// ─── Datasource provider ──────────────────────────────────────────────────────

final procedureRemoteDsProvider = Provider<ProcedureRemoteDataSource>((ref) {
  return ProcedureRemoteDataSource(ref.watch(dioProvider));
});

// ─── Procedure list state ─────────────────────────────────────────────────────

class ProcedureListState {
  final List<ProcedureActModel> procedures;
  final bool isLoading;
  final String? error;
  final String? statusFilter;
  final String? typeFilter;
  final int totalCount;

  const ProcedureListState({
    this.procedures = const [],
    this.isLoading = false,
    this.error,
    this.statusFilter,
    this.typeFilter,
    this.totalCount = 0,
  });

  ProcedureListState copyWith({
    List<ProcedureActModel>? procedures,
    bool? isLoading,
    String? error,
    String? statusFilter,
    String? typeFilter,
    int? totalCount,
    bool clearError = false,
  }) {
    return ProcedureListState(
      procedures: procedures ?? this.procedures,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      statusFilter: statusFilter ?? this.statusFilter,
      typeFilter: typeFilter ?? this.typeFilter,
      totalCount: totalCount ?? this.totalCount,
    );
  }
}

class ProcedureListNotifier extends StateNotifier<ProcedureListState> {
  final ProcedureRemoteDataSource _ds;

  ProcedureListNotifier(this._ds) : super(const ProcedureListState()) {
    load();
  }

  Future<void> load() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final response = await _ds.getProcedures(
        status: state.statusFilter,
        procedureType: state.typeFilter,
        pageSize: 50,
      );
      state = state.copyWith(
        procedures: response.items,
        totalCount: response.total,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void filterByStatus(String? status) {
    state = state.copyWith(statusFilter: status);
    load();
  }

  void filterByType(String? type) {
    state = state.copyWith(typeFilter: type);
    load();
  }

  Future<void> refresh() => load();

  Future<ProcedureActModel?> createProcedure(Map<String, dynamic> data) async {
    try {
      final procedure = await _ds.createProcedure(data);
      await load(); // refresh list
      return procedure;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return null;
    }
  }
}

final procedureListProvider =
    StateNotifierProvider<ProcedureListNotifier, ProcedureListState>((ref) {
  return ProcedureListNotifier(ref.watch(procedureRemoteDsProvider));
});

// ─── Single procedure detail ──────────────────────────────────────────────────

final procedureDetailProvider =
    FutureProvider.family<ProcedureActModel, String>((ref, id) async {
  return ref.watch(procedureRemoteDsProvider).getProcedureById(id);
});
