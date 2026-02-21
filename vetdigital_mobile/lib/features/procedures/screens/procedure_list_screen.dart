import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';

/// Veterinary procedure acts list screen.
/// Shows acts created by the current user's organization.
class ProcedureListScreen extends StatefulWidget {
  const ProcedureListScreen({super.key});

  @override
  State<ProcedureListScreen> createState() => _ProcedureListScreenState();
}

class _ProcedureListScreenState extends State<ProcedureListScreen> {
  final _searchController = TextEditingController();
  String _selectedFilter = 'all';

  // Demo data matching backend ProcedureAct model
  final List<Map<String, dynamic>> _demoActs = [
    {
      'id': 'proc-001',
      'act_number': 'АКТ-2025-001',
      'procedure_type': 'vaccination',
      'disease_name': 'Ящур',
      'species': 'cattle',
      'total_vaccinated': 45,
      'status': 'signed',
      'date': '2025-03-15',
      'veterinarian': 'Сейтқали А.М.',
      'region': 'Алматы облысы',
    },
    {
      'id': 'proc-002',
      'act_number': 'АКТ-2025-002',
      'procedure_type': 'allergy_test',
      'disease_name': 'Туберкулез',
      'species': 'cattle',
      'total_vaccinated': 30,
      'status': 'draft',
      'date': '2025-03-20',
      'veterinarian': 'Сейтқали А.М.',
      'region': 'Алматы облысы',
    },
    {
      'id': 'proc-003',
      'act_number': 'АКТ-2025-003',
      'procedure_type': 'vaccination',
      'disease_name': 'Бруцеллез',
      'species': 'sheep',
      'total_vaccinated': 120,
      'status': 'signed',
      'date': '2025-03-22',
      'veterinarian': 'Ахметов Б.К.',
      'region': 'Жамбыл облысы',
    },
    {
      'id': 'proc-004',
      'act_number': 'АКТ-2025-004',
      'procedure_type': 'vaccination',
      'disease_name': 'Сибирская язва',
      'species': 'horses',
      'total_vaccinated': 18,
      'status': 'pending_signature',
      'date': '2025-03-25',
      'veterinarian': 'Нурпеисов Д.С.',
      'region': 'ШҚО',
    },
  ];

  List<Map<String, dynamic>> get _filtered {
    var list = _demoActs;
    if (_selectedFilter != 'all') {
      list = list.where((a) => a['status'] == _selectedFilter).toList();
    }
    final q = _searchController.text.toLowerCase();
    if (q.isNotEmpty) {
      list = list.where((a) =>
        a['act_number'].toLowerCase().contains(q) ||
        a['disease_name'].toLowerCase().contains(q) ||
        a['veterinarian'].toLowerCase().contains(q)
      ).toList();
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Акты процедур'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterSheet,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/procedures/create'),
        icon: const Icon(Icons.add),
        label: const Text('Новый акт'),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Поиск по номеру, болезни, врачу...',
                prefixIcon: const Icon(Icons.search),
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),

          // Status filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Row(
              children: [
                _FilterChip(label: 'Все', value: 'all', selected: _selectedFilter == 'all', onTap: () => setState(() => _selectedFilter = 'all')),
                _FilterChip(label: 'Подписан', value: 'signed', selected: _selectedFilter == 'signed', onTap: () => setState(() => _selectedFilter = 'signed')),
                _FilterChip(label: 'Черновик', value: 'draft', selected: _selectedFilter == 'draft', onTap: () => setState(() => _selectedFilter = 'draft')),
                _FilterChip(label: 'Ожид. подписи', value: 'pending_signature', selected: _selectedFilter == 'pending_signature', onTap: () => setState(() => _selectedFilter = 'pending_signature')),
              ],
            ),
          ),

          // Results count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                Text(
                  'Найдено: ${_filtered.length}',
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                ),
              ],
            ),
          ),

          // List
          Expanded(
            child: _filtered.isEmpty
                ? const Center(child: Text('Нет актов'))
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 80),
                    itemCount: _filtered.length,
                    itemBuilder: (_, i) => _ProcedureActCard(
                      act: _filtered[i],
                      onTap: () => context.go('/procedures/${_filtered[i]['id']}'),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Фильтр', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),
            const Text('Тип процедуры'),
            Wrap(
              spacing: 8,
              children: [
                FilterChip(label: const Text('Вакцинация'), selected: false, onSelected: (_) {}),
                FilterChip(label: const Text('Аллерг. тест'), selected: false, onSelected: (_) {}),
                FilterChip(label: const Text('Дегельминтизация'), selected: false, onSelected: (_) {}),
              ],
            ),
            const SizedBox(height: 8),
            const Text('Вид животных'),
            Wrap(
              spacing: 8,
              children: [
                FilterChip(label: const Text('КРС'), selected: false, onSelected: (_) {}),
                FilterChip(label: const Text('МРС'), selected: false, onSelected: (_) {}),
                FilterChip(label: const Text('Лошади'), selected: false, onSelected: (_) {}),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Применить'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final String value;
  final bool selected;
  final VoidCallback onTap;
  const _FilterChip({required this.label, required this.value, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Chip(
          label: Text(label),
          backgroundColor: selected ? AppColors.primary : Colors.grey[200],
          labelStyle: TextStyle(
            color: selected ? Colors.white : AppColors.textPrimary,
            fontSize: 12,
          ),
          visualDensity: VisualDensity.compact,
        ),
      ),
    );
  }
}

class _ProcedureActCard extends StatelessWidget {
  final Map<String, dynamic> act;
  final VoidCallback onTap;
  const _ProcedureActCard({required this.act, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final status = act['status'] as String;
    final type = act['procedure_type'] as String;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: _typeColor(type).withOpacity(0.1),
          child: Icon(_typeIcon(type), color: _typeColor(type), size: 20),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                act['act_number'],
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
            _StatusBadge(status: status),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${_typeLabel(type)} • ${act['disease_name']}',
              style: const TextStyle(fontSize: 12),
            ),
            Row(
              children: [
                const Icon(Icons.location_on, size: 11, color: AppColors.textSecondary),
                const SizedBox(width: 2),
                Text(act['region'], style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                const Spacer(),
                const Icon(Icons.pets, size: 11, color: AppColors.textSecondary),
                const SizedBox(width: 2),
                Text('${act['total_vaccinated']} голов', style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                const SizedBox(width: 8),
                Text(act['date'], style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
              ],
            ),
          ],
        ),
        isThreeLine: true,
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }

  Color _typeColor(String type) {
    switch (type) {
      case 'vaccination': return AppColors.success;
      case 'allergy_test': return AppColors.warning;
      default: return AppColors.primary;
    }
  }

  IconData _typeIcon(String type) {
    switch (type) {
      case 'vaccination': return Icons.vaccines;
      case 'allergy_test': return Icons.biotech;
      default: return Icons.medical_services;
    }
  }

  String _typeLabel(String type) {
    switch (type) {
      case 'vaccination': return 'Вакцинация';
      case 'allergy_test': return 'Аллерг. тест';
      case 'deworming': return 'Дегельм.';
      default: return type;
    }
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;
    switch (status) {
      case 'signed':
        color = AppColors.success;
        label = 'Подписан';
        break;
      case 'draft':
        color = AppColors.textSecondary;
        label = 'Черновик';
        break;
      case 'pending_signature':
        color = AppColors.warning;
        label = 'Ожид.';
        break;
      default:
        color = AppColors.textSecondary;
        label = status;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(label, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w600)),
    );
  }
}
