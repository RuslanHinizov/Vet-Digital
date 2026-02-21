import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/network/api_client.dart';
import '../../../core/config/api_endpoints.dart';
import '../../../shared/widgets/loading_states.dart';

// ─── Data Models ──────────────────────────────────────────────────────────────

class HealthRecord {
  final String id;
  final String actNumber;
  final String procedureType;
  final String? diseaseName;
  final String? vaccineName;
  final String? allergenName;
  final DateTime actDate;
  final String? result;  // for allergy test
  final String status;

  const HealthRecord({
    required this.id,
    required this.actNumber,
    required this.procedureType,
    this.diseaseName,
    this.vaccineName,
    this.allergenName,
    required this.actDate,
    this.result,
    required this.status,
  });

  factory HealthRecord.fromJson(Map<String, dynamic> json) {
    return HealthRecord(
      id: json['id'] as String? ?? '',
      actNumber: json['act_number'] as String? ?? '—',
      procedureType: json['procedure_type'] as String? ?? 'vaccination',
      diseaseName: json['disease_name'] as String?,
      vaccineName: json['vaccine_name'] as String?,
      allergenName: json['allergen_name'] as String?,
      actDate: DateTime.tryParse(json['act_date'] as String? ?? '') ?? DateTime.now(),
      result: json['allergy_result'] as String?,
      status: json['status'] as String? ?? 'signed',
    );
  }
}

// ─── Providers ────────────────────────────────────────────────────────────────

final animalHealthProvider =
    FutureProvider.family<List<HealthRecord>, String>((ref, animalId) async {
  try {
    final dio = ref.watch(dioProvider);
    final response = await dio.get(ApiEndpoints.animalHealth(animalId));
    final data = response.data;
    if (data is List) {
      return data.cast<Map<String, dynamic>>().map(HealthRecord.fromJson).toList();
    }
    // Backend may return {items: [...]}
    final items = (data as Map<String, dynamic>)['items'] as List? ?? [];
    return items.cast<Map<String, dynamic>>().map(HealthRecord.fromJson).toList();
  } catch (e) {
    // Return demo data in dev
    return _demoHealthRecords();
  }
});

List<HealthRecord> _demoHealthRecords() => [
      HealthRecord(
        id: '1',
        actNumber: 'АКТ-2024-001',
        procedureType: 'vaccination',
        diseaseName: 'Ящур',
        vaccineName: 'Фортдодж ящур',
        actDate: DateTime(2024, 5, 15),
        status: 'signed',
      ),
      HealthRecord(
        id: '2',
        actNumber: 'АКТ-2024-002',
        procedureType: 'allergy_test',
        diseaseName: 'Туберкулёз',
        allergenName: 'ППД-туберкулин',
        actDate: DateTime(2024, 3, 22),
        result: 'negative',
        status: 'signed',
      ),
      HealthRecord(
        id: '3',
        actNumber: 'АКТ-2023-115',
        procedureType: 'deworming',
        vaccineName: 'Альвет',
        actDate: DateTime(2023, 11, 10),
        status: 'signed',
      ),
    ];

// ─── Screen ───────────────────────────────────────────────────────────────────

class AnimalHealthScreen extends ConsumerWidget {
  final String animalId;
  final String? animalName;

  const AnimalHealthScreen({
    super.key,
    required this.animalId,
    this.animalName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncHealth = ref.watch(animalHealthProvider(animalId));

    return Scaffold(
      appBar: AppBar(
        title: Text(animalName != null
            ? 'Здоровье: $animalName'
            : 'История здоровья'),
      ),
      body: asyncHealth.when(
        loading: () => const LoadingPage(),
        error: (e, _) => ErrorPage(
          message: e.toString(),
          onRetry: () => ref.invalidate(animalHealthProvider(animalId)),
        ),
        data: (records) => records.isEmpty
            ? const EmptyState(
                icon: Icons.healing,
                title: 'Нет записей',
                subtitle: 'История ветеринарных мероприятий для этого животного пуста',
              )
            : _HealthTimeline(records: records),
      ),
    );
  }
}

// ─── Timeline ─────────────────────────────────────────────────────────────────

class _HealthTimeline extends StatelessWidget {
  final List<HealthRecord> records;
  const _HealthTimeline({required this.records});

  @override
  Widget build(BuildContext context) {
    // Group by year
    final byYear = <int, List<HealthRecord>>{};
    for (final r in records) {
      byYear.putIfAbsent(r.actDate.year, () => []).add(r);
    }
    final years = byYear.keys.toList()..sort((a, b) => b.compareTo(a));

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: years.length,
      itemBuilder: (context, i) {
        final year = years[i];
        final yearRecords = byYear[year]!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      year.toString(),
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Expanded(child: Divider(indent: 8)),
                ],
              ),
            ),
            ...yearRecords.map((r) => _HealthRecordTile(record: r)),
          ],
        );
      },
    );
  }
}

class _HealthRecordTile extends StatelessWidget {
  final HealthRecord record;
  const _HealthRecordTile({required this.record});

  @override
  Widget build(BuildContext context) {
    final (icon, color, typeLabel) = switch (record.procedureType) {
      'vaccination' => (Icons.vaccines, Colors.blue, 'Вакцинация'),
      'allergy_test' => (Icons.biotech, Colors.orange, 'Аллерг. тест'),
      'deworming' => (Icons.bug_report, Colors.purple, 'Дегельминтизация'),
      'treatment' => (Icons.medical_services, Colors.red, 'Лечение'),
      _ => (Icons.medical_services, AppColors.primary, record.procedureType),
    };

    final dateStr = DateFormat('dd.MM.yyyy').format(record.actDate);
    final drugName = record.vaccineName ?? record.allergenName ?? '—';

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // Colored left border indicator
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Icon(icon, color: color, size: 28),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          typeLabel,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: color,
                            fontSize: 13,
                          ),
                        ),
                        Text(dateStr,
                            style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      record.diseaseName ?? drugName,
                      style: const TextStyle(fontSize: 13),
                    ),
                    if (record.vaccineName != null &&
                        record.diseaseName != null) ...[
                      Text(
                        record.vaccineName!,
                        style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                      ),
                    ],
                    if (record.result != null) ...[
                      const SizedBox(height: 4),
                      _AllergyResultChip(result: record.result!),
                    ],
                    const SizedBox(height: 4),
                    Text(
                      'Акт: ${record.actNumber}',
                      style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(12),
              child: Icon(Icons.verified, color: Colors.green, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class _AllergyResultChip extends StatelessWidget {
  final String result;
  const _AllergyResultChip({required this.result});

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (result) {
      'negative' => ('(-) Отрицательный', Colors.green),
      'positive' => ('(+) Положительный', Colors.red),
      'doubtful' => ('(±) Сомнительный', Colors.orange),
      _ => (result, Colors.grey),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w500),
      ),
    );
  }
}
