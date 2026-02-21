import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class AnimalDetailScreen extends StatelessWidget {
  final String animalId;
  const AnimalDetailScreen({super.key, required this.animalId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Карточка животного'),
        actions: [
          IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Animal header
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: AppColors.primary.withOpacity(0.1),
                      child: const Icon(Icons.pets, color: AppColors.primary, size: 32),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ID: $animalId',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const Text('Крупный рогатый скот', style: TextStyle(color: AppColors.textSecondary)),
                          const Chip(
                            label: Text('Активный'),
                            backgroundColor: Color(0xFFE8F5E9),
                            labelStyle: TextStyle(color: AppColors.statusActive, fontSize: 11),
                            visualDensity: VisualDensity.compact,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Animal details
            _SectionCard(
              title: 'Идентификация',
              children: const [
                _DetailRow(label: 'Нац. номер', value: '—'),
                _DetailRow(label: 'Микрочип', value: '—'),
                _DetailRow(label: 'RFID метка', value: '—'),
              ],
            ),
            const SizedBox(height: 12),

            _SectionCard(
              title: 'Характеристики',
              children: const [
                _DetailRow(label: 'Вид', value: '—'),
                _DetailRow(label: 'Порода', value: '—'),
                _DetailRow(label: 'Пол', value: '—'),
                _DetailRow(label: 'Дата рождения', value: '—'),
                _DetailRow(label: 'Масть', value: '—'),
                _DetailRow(label: 'Вес', value: '—'),
              ],
            ),
            const SizedBox(height: 12),

            _SectionCard(
              title: 'Владелец',
              children: const [
                _DetailRow(label: 'ФИО', value: '—'),
                _DetailRow(label: 'ИИН', value: '—'),
                _DetailRow(label: 'Телефон', value: '—'),
                _DetailRow(label: 'Хозяйство', value: '—'),
              ],
            ),
            const SizedBox(height: 12),

            // Health history (TODO: load vaccination records)
            _SectionCard(
              title: 'История вакцинаций',
              children: const [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('История пуста', style: TextStyle(color: AppColors.textSecondary)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _SectionCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.primary)),
            const Divider(),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
          ),
        ],
      ),
    );
  }
}
