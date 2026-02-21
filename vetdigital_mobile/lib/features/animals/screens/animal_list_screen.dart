import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';

class AnimalListScreen extends ConsumerStatefulWidget {
  const AnimalListScreen({super.key});

  @override
  ConsumerState<AnimalListScreen> createState() => _AnimalListScreenState();
}

class _AnimalListScreenState extends ConsumerState<AnimalListScreen> {
  final _searchController = TextEditingController();
  String? _selectedSpecies;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Животные'),
        actions: [
          IconButton(
            icon: const Icon(Icons.nfc),
            tooltip: 'Сканировать RFID',
            onPressed: () => context.go('/animals/rfid-scan'),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Поиск по ID, чипу, RFID...',
                      prefixIcon: Icon(Icons.search),
                      isDense: true,
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(width: 8),
                // Species filter chip
                FilterChip(
                  label: Text(_selectedSpecies ?? 'Все виды'),
                  selected: _selectedSpecies != null,
                  onSelected: (_) => _showSpeciesFilter(),
                ),
              ],
            ),
          ),

          // Animals list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: 0, // TODO: Load from API/local DB
              itemBuilder: (ctx, i) => const SizedBox(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/animals/register'),
        icon: const Icon(Icons.add),
        label: const Text('Добавить'),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  void _showSpeciesFilter() {
    showModalBottomSheet(
      context: context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(title: const Text('Все виды'), onTap: () {
            setState(() => _selectedSpecies = null);
            Navigator.pop(context);
          }),
          ListTile(title: const Text('КРС (ірі қара мал)'), onTap: () {
            setState(() => _selectedSpecies = 'cattle');
            Navigator.pop(context);
          }),
          ListTile(title: const Text('МРС - Овцы'), onTap: () {
            setState(() => _selectedSpecies = 'sheep');
            Navigator.pop(context);
          }),
          ListTile(title: const Text('Лошади (жылқы)'), onTap: () {
            setState(() => _selectedSpecies = 'horse');
            Navigator.pop(context);
          }),
          ListTile(title: const Text('Верблюды (түйе)'), onTap: () {
            setState(() => _selectedSpecies = 'camel');
            Navigator.pop(context);
          }),
        ],
      ),
    );
  }
}
