import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../data/models/animal.dart';

/// Reusable animal list card widget.
class AnimalCard extends StatelessWidget {
  final AnimalModel animal;
  final VoidCallback? onTap;
  final bool showLocation;

  const AnimalCard({
    super.key,
    required this.animal,
    this.onTap,
    this.showLocation = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: _speciesColor().withOpacity(0.15),
          child: Text(
            _speciesEmoji(),
            style: const TextStyle(fontSize: 20),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                animal.identificationNo ?? animal.id,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
            _StatusChip(status: animal.status ?? 'active'),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${animal.speciesName ?? _speciesLabel()} • ${animal.sex == 'male' ? 'Самец' : 'Самка'}'
              '${animal.breedName != null ? ' • ${animal.breedName}' : ''}',
              style: const TextStyle(fontSize: 12),
            ),
            if (animal.ownerName != null)
              Row(
                children: [
                  const Icon(Icons.person_outline, size: 11, color: AppColors.textSecondary),
                  const SizedBox(width: 3),
                  Text(
                    animal.ownerName!,
                    style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                  ),
                ],
              ),
            if (showLocation && animal.lastLatitude != null)
              Row(
                children: [
                  const Icon(Icons.gps_fixed, size: 11, color: AppColors.success),
                  const SizedBox(width: 3),
                  Text(
                    '${animal.lastLatitude!.toStringAsFixed(4)}, '
                    '${animal.lastLongitude!.toStringAsFixed(4)}',
                    style: const TextStyle(fontSize: 10, color: AppColors.success),
                  ),
                ],
              ),
          ],
        ),
        isThreeLine: true,
        trailing: animal.isSynced
            ? const Icon(Icons.chevron_right)
            : const Icon(Icons.cloud_off, color: AppColors.warning, size: 16),
      ),
    );
  }

  Color _speciesColor() {
    switch (animal.speciesId) {
      case 'cattle': return AppColors.primary;
      case 'sheep': return AppColors.secondary;
      case 'horses': return AppColors.accent;
      case 'camels': return AppColors.warning;
      default: return AppColors.textSecondary;
    }
  }

  String _speciesEmoji() {
    switch (animal.speciesId) {
      case 'cattle': return '🐄';
      case 'sheep': return '🐑';
      case 'horses': return '🐎';
      case 'camels': return '🐪';
      case 'pigs': return '🐖';
      case 'goats': return '🐐';
      default: return '🐾';
    }
  }

  String _speciesLabel() {
    switch (animal.speciesId) {
      case 'cattle': return 'КРС';
      case 'sheep': return 'МРС (овца)';
      case 'horses': return 'Лошадь';
      case 'camels': return 'Верблюд';
      case 'pigs': return 'Свинья';
      case 'goats': return 'Коза';
      default: return 'Животное';
    }
  }
}

class _StatusChip extends StatelessWidget {
  final String status;
  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;
    switch (status) {
      case 'active':
        color = AppColors.statusActive;
        label = 'Активный';
        break;
      case 'deceased':
        color = AppColors.statusDeceased;
        label = 'Выбыл';
        break;
      case 'sold':
        color = AppColors.statusSold;
        label = 'Продан';
        break;
      case 'lost':
        color = AppColors.statusLost;
        label = 'Потерян';
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
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w600),
      ),
    );
  }
}
