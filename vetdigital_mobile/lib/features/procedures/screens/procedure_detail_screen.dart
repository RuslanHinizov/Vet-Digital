import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/procedure.dart';
import '../../../providers/procedure_providers.dart';
import '../../../shared/widgets/loading_states.dart';

class ProcedureDetailScreen extends ConsumerWidget {
  final String procedureId;
  const ProcedureDetailScreen({super.key, required this.procedureId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncProcedure = ref.watch(procedureDetailProvider(procedureId));

    return asyncProcedure.when(
      loading: () => const LoadingPage(),
      error: (e, _) => ErrorPage(
        message: e.toString(),
        onRetry: () => ref.invalidate(procedureDetailProvider(procedureId)),
      ),
      data: (procedure) => _ProcedureDetailContent(procedure: procedure),
    );
  }
}

class _ProcedureDetailContent extends ConsumerWidget {
  final ProcedureActModel procedure;
  const _ProcedureDetailContent({required this.procedure});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Акт ${procedure.actNumber}'),
        actions: [
          _StatusChip(status: procedure.status ?? 'draft'),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ActMetaCard(procedure: procedure),
            const SizedBox(height: 12),
            _AnimalCountCard(procedure: procedure),
            const SizedBox(height: 12),
            _VaccineInfoCard(procedure: procedure),
            if ((procedure.animals).isNotEmpty) ...[
              const SizedBox(height: 12),
              _AnimalsTable(animals: procedure.animals),
            ],
            if ((procedure.materialsJson ?? '').isNotEmpty) ...[
              const SizedBox(height: 12),
              _MaterialsCard(materialsJson: procedure.materialsJson!),
            ],
            const SizedBox(height: 12),
            _SignatureSection(procedure: procedure),
            const SizedBox(height: 24),
            _ActionButtons(procedure: procedure),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

// ─── Status chip ─────────────────────────────────────────────────────────────

class _StatusChip extends StatelessWidget {
  final String status;
  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      'signed' => ('Подписан', Colors.green),
      'pending_signature' => ('Ожидает подпись', Colors.orange),
      'archived' => ('Архив', Colors.grey),
      _ => ('Черновик', Colors.blue),
    };
    return Chip(
      label: Text(label, style: const TextStyle(fontSize: 11, color: Colors.white)),
      backgroundColor: color,
      padding: EdgeInsets.zero,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}

// ─── Act metadata card ────────────────────────────────────────────────────────

class _ActMetaCard extends StatelessWidget {
  final ProcedureActModel procedure;
  const _ActMetaCard({required this.procedure});

  @override
  Widget build(BuildContext context) {
    final dateStr = procedure.actDate != null
        ? DateFormat('dd.MM.yyyy').format(procedure.actDate)
        : '—';
    final procedureTypeLabel = {
      'vaccination': 'Вакцинация',
      'allergy_test': 'Аллергический тест',
      'deworming': 'Дегельминтизация',
      'treatment': 'Лечение',
    }[procedure.procedureType] ?? procedure.procedureType;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Основные сведения',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    )),
            const Divider(),
            _InfoRow('Номер акта', procedure.actNumber),
            _InfoRow('Дата', dateStr),
            _InfoRow('Тип процедуры', procedureTypeLabel),
            _InfoRow('Болезнь / ауру', procedure.diseaseName ?? '—'),
            _InfoRow('Нас. пункт', procedure.settlement ?? '—'),
            _InfoRow('Регион (КАТО)', procedure.regionName ?? procedure.regionKato ?? '—'),
            _InfoRow('Специалист', procedure.specialistName ?? '—'),
            _InfoRow('Владелец', procedure.ownerName ?? '—'),
            _InfoRow('ИИН владельца', procedure.ownerIin ?? '—'),
          ],
        ),
      ),
    );
  }
}

// ─── Animal count card ────────────────────────────────────────────────────────

class _AnimalCountCard extends StatelessWidget {
  final ProcedureActModel procedure;
  const _AnimalCountCard({required this.procedure});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Количество животных',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    )),
            const Divider(),
            _InfoRow('Вид', procedure.speciesName ?? '—'),
            Row(
              children: [
                Expanded(child: _CountBox('Самцы', procedure.maleCount ?? 0)),
                const SizedBox(width: 8),
                Expanded(child: _CountBox('Самки', procedure.femaleCount ?? 0)),
                const SizedBox(width: 8),
                Expanded(child: _CountBox('Молодняк', procedure.youngCount ?? 0)),
                const SizedBox(width: 8),
                Expanded(
                  child: _CountBox('Итого', procedure.totalVaccinated ?? 0,
                      highlight: true),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CountBox extends StatelessWidget {
  final String label;
  final int count;
  final bool highlight;
  const _CountBox(this.label, this.count, {this.highlight = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: highlight ? AppColors.primary : AppColors.primaryLight.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: highlight ? Colors.white : AppColors.primary,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: highlight ? Colors.white70 : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Vaccine info card ────────────────────────────────────────────────────────

class _VaccineInfoCard extends StatelessWidget {
  final ProcedureActModel procedure;
  const _VaccineInfoCard({required this.procedure});

  @override
  Widget build(BuildContext context) {
    final drugName = procedure.vaccineName ?? procedure.allergenName ?? '—';
    final prodDateStr = procedure.productionDate != null
        ? DateFormat('MM.yyyy').format(procedure.productionDate!)
        : '—';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Препарат',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    )),
            const Divider(),
            _InfoRow('Наименование', drugName),
            _InfoRow('Производитель', procedure.manufacturer ?? '—'),
            _InfoRow('Серия', procedure.series ?? '—'),
            _InfoRow('Дата производства', prodDateStr),
            _InfoRow('№ гос. контроля', procedure.stateControlNo ?? '—'),
            _InfoRow('Метод введения', procedure.injectionMethod ?? '—'),
            _InfoRow('Доза (взр.)', '${procedure.doseAdultMl ?? "—"} мл'),
            _InfoRow('Доза (мол.)', '${procedure.doseYoungMl ?? "—"} мл'),
            if (procedure.allergenReadingHours != null)
              _InfoRow('Чтение аллергена', '${procedure.allergenReadingHours} ч'),
          ],
        ),
      ),
    );
  }
}

// ─── Animals table ────────────────────────────────────────────────────────────

class _AnimalsTable extends StatelessWidget {
  final List<ProcedureActAnimalModel> animals;
  const _AnimalsTable({required this.animals});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Реестр животных (${animals.length})',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    )),
            const Divider(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: WidgetStateProperty.all(
                  AppColors.primary.withOpacity(0.1),
                ),
                columns: const [
                  DataColumn(label: Text('#')),
                  DataColumn(label: Text('ID / Ном.')),
                  DataColumn(label: Text('Пол')),
                  DataColumn(label: Text('Возраст')),
                  DataColumn(label: Text('Результат')),
                ],
                rows: animals.asMap().entries.map((entry) {
                  final i = entry.key;
                  final a = entry.value;
                  final result = a.allergyResult != null
                      ? _allergyLabel(a.allergyResult!)
                      : '—';
                  return DataRow(cells: [
                    DataCell(Text('${i + 1}')),
                    DataCell(Text(a.identificationNo ?? a.animalId ?? '—')),
                    DataCell(Text(a.sex == 'male' ? 'М' : a.sex == 'female' ? 'Ж' : '—')),
                    DataCell(Text(a.ageGroup == 'adult' ? 'Взр.' : a.ageGroup == 'young' ? 'Мол.' : '—')),
                    DataCell(Text(result)),
                  ]);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _allergyLabel(String result) {
    return switch (result) {
      'negative' => '(-) Отрицат.',
      'positive' => '(+) Положит.',
      'doubtful' => '(±) Сомнит.',
      _ => result,
    };
  }
}

// ─── Materials card ───────────────────────────────────────────────────────────

class _MaterialsCard extends StatelessWidget {
  final String materialsJson;
  const _MaterialsCard({required this.materialsJson});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> materials = [];
    try {
      final raw = jsonDecode(materialsJson) as List;
      materials = raw.cast<Map<String, dynamic>>();
    } catch (_) {}

    if (materials.isEmpty) return const SizedBox.shrink();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Расходные материалы',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    )),
            const Divider(),
            ...materials.map((m) => _InfoRow(
                  m['name']?.toString() ?? '—',
                  '${m['quantity']} ${m['unit'] ?? ''}',
                )),
          ],
        ),
      ),
    );
  }
}

// ─── Signature section ────────────────────────────────────────────────────────

class _SignatureSection extends StatelessWidget {
  final ProcedureActModel procedure;
  const _SignatureSection({required this.procedure});

  @override
  Widget build(BuildContext context) {
    if (procedure.status == 'signed' && procedure.signedAt != null) {
      final signedStr = DateFormat('dd.MM.yyyy HH:mm').format(procedure.signedAt!);
      return Card(
        color: Colors.green[50],
        child: ListTile(
          leading: const Icon(Icons.verified, color: Colors.green, size: 32),
          title: const Text('ЭЦП подписан', style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('Подписан: $signedStr UTC'),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}

// ─── Action buttons ───────────────────────────────────────────────────────────

class _ActionButtons extends ConsumerStatefulWidget {
  final ProcedureActModel procedure;
  const _ActionButtons({required this.procedure});

  @override
  ConsumerState<_ActionButtons> createState() => _ActionButtonsState();
}

class _ActionButtonsState extends ConsumerState<_ActionButtons> {
  bool _signingInProgress = false;
  String? _qrData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // PDF download
        OutlinedButton.icon(
          icon: const Icon(Icons.picture_as_pdf),
          label: const Text('Скачать PDF'),
          onPressed: () => context.push(
            '/documents/${widget.procedure.id}?type=procedure_act',
          ),
        ),
        const SizedBox(height: 8),

        // EDS signing (only if not signed)
        if (widget.procedure.status != 'signed') ...[
          ElevatedButton.icon(
            icon: const Icon(Icons.draw),
            label: Text(_signingInProgress ? 'Загрузка QR...' : 'Подписать ЭЦП'),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            onPressed: _signingInProgress ? null : _initiateEds,
          ),
          if (_qrData != null) ...[
            const SizedBox(height: 16),
            _EdsQrPanel(qrData: _qrData!),
          ],
        ],
      ],
    );
  }

  Future<void> _initiateEds() async {
    setState(() => _signingInProgress = true);
    try {
      final ds = ref.read(procedureRemoteDsProvider);
      final result = await ds.initiateSign(widget.procedure.id);
      setState(() {
        _qrData = result['qr_data'] as String?;
        _signingInProgress = false;
      });
    } catch (e) {
      setState(() => _signingInProgress = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }
}

class _EdsQrPanel extends StatelessWidget {
  final String qrData;
  const _EdsQrPanel({required this.qrData});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue[50],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Icon(Icons.qr_code, size: 32, color: AppColors.primary),
            const SizedBox(height: 8),
            const Text(
              'Откройте eGov Mobile и отсканируйте QR-код для подписания',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 12),
            Center(
              child: QrImageView(data: qrData, size: 180),
            ),
            const SizedBox(height: 8),
            const Text(
              'После подписания обновите страницу',
              style: TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Helper widget ────────────────────────────────────────────────────────────

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(label,
                style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}
