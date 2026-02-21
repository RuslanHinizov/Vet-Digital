import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// Compact sync status chip shown in AppBar or bottom nav.
/// Displays pending sync count and last sync time.
class SyncStatusIndicator extends StatelessWidget {
  final int pendingCount;
  final bool isSyncing;
  final DateTime? lastSyncAt;
  final VoidCallback? onTap;

  const SyncStatusIndicator({
    super.key,
    this.pendingCount = 0,
    this.isSyncing = false,
    this.lastSyncAt,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (isSyncing) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.info.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 12,
                height: 12,
                child: CircularProgressIndicator(strokeWidth: 1.5, color: AppColors.info),
              ),
              SizedBox(width: 6),
              Text('Синхронизация...', style: TextStyle(fontSize: 11, color: AppColors.info)),
            ],
          ),
        ),
      );
    }

    if (pendingCount > 0) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.warning.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.cloud_upload_outlined, size: 13, color: AppColors.warning),
              const SizedBox(width: 4),
              Text(
                '$pendingCount не синхр.',
                style: const TextStyle(fontSize: 11, color: AppColors.warning),
              ),
            ],
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.success.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cloud_done, size: 13, color: AppColors.success),
            SizedBox(width: 4),
            Text('Синхр.', style: TextStyle(fontSize: 11, color: AppColors.success)),
          ],
        ),
      ),
    );
  }
}

/// Full sync status screen (accessible from Profile screen).
class SyncStatusScreen extends StatelessWidget {
  const SyncStatusScreen({super.key});

  // Demo pending queue items
  static const _pendingItems = [
    {'type': 'animal_create', 'id': 'local-001', 'time': '14:32', 'desc': 'Новое животное КЗ-2025-003482'},
    {'type': 'procedure_create', 'id': 'local-002', 'time': '14:45', 'desc': 'Акт АКТ-2025-067 (черновик)'},
    {'type': 'animal_update', 'id': 'local-003', 'time': '15:01', 'desc': 'Обновление веса #KZ-00123'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Синхронизация')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Status card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Icon(Icons.cloud_sync, size: 48, color: AppColors.warning),
                  const SizedBox(height: 8),
                  Text(
                    '${_pendingItems.length} элементов ожидают синхронизации',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Последняя синхронизация: 15:05 сегодня',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.sync),
                    label: const Text('Синхронизировать сейчас'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          const Text('Ожидающие изменения',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 8),
          ..._pendingItems.map((item) => Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: Icon(
                _iconFor(item['type']!),
                color: AppColors.warning,
              ),
              title: Text(item['desc']!, style: const TextStyle(fontSize: 13)),
              subtitle: Text('${_typeLabel(item['type']!)} • ${item['time']}',
                  style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
              trailing: const Icon(Icons.schedule, size: 16, color: AppColors.warning),
            ),
          )),

          const SizedBox(height: 16),
          const Text('Настройки синхронизации',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Авто-синхронизация', style: TextStyle(fontSize: 14)),
                  subtitle: const Text('Синхронизировать при появлении сети',
                      style: TextStyle(fontSize: 12)),
                  value: true,
                  onChanged: (_) {},
                  dense: true,
                ),
                SwitchListTile(
                  title: const Text('Только по Wi-Fi', style: TextStyle(fontSize: 14)),
                  subtitle: const Text('Не использовать мобильный интернет',
                      style: TextStyle(fontSize: 12)),
                  value: false,
                  onChanged: (_) {},
                  dense: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _iconFor(String type) {
    switch (type) {
      case 'animal_create':
      case 'animal_update':
        return Icons.pets;
      case 'procedure_create':
        return Icons.vaccines;
      default:
        return Icons.cloud_upload;
    }
  }

  String _typeLabel(String type) {
    switch (type) {
      case 'animal_create': return 'Создание животного';
      case 'animal_update': return 'Обновление животного';
      case 'procedure_create': return 'Создание акта';
      default: return type;
    }
  }
}
