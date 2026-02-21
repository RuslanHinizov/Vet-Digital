import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../providers/auth_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final role = authState.role ?? 'farmer';

    return Scaffold(
      appBar: AppBar(
        title: const Text('VetDigital'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {/* TODO: notifications */},
          ),
          // Sync status indicator
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: _SyncIndicator(),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {/* TODO: refresh dashboard */},
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting
              _WelcomeCard(role: role),
              const SizedBox(height: 16),

              // Quick stats
              _StatsGrid(),
              const SizedBox(height: 16),

              // Quick actions based on role
              Text(
                'Быстрые действия',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              _QuickActions(role: role),
              const SizedBox(height: 16),

              // Recent alerts
              Text(
                'Последние уведомления',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              _RecentAlerts(),
            ],
          ),
        ),
      ),
    );
  }
}

class _WelcomeCard extends StatelessWidget {
  final String role;
  const _WelcomeCard({required this.role});

  String get _roleLabel {
    switch (role) {
      case 'veterinarian': return 'Ветеринарный врач';
      case 'inspector': return 'Государственный инспектор';
      case 'lab': return 'Сотрудник лаборатории';
      case 'supplier': return 'Поставщик';
      default: return 'Фермер';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.primary, AppColors.primaryLight],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Добро пожаловать!',
                    style: const TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                  Text(
                    _roleLabel,
                    style: const TextStyle(
                      color: Colors.white, fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const CircleAvatar(
              backgroundColor: Colors.white24,
              child: Icon(Icons.person, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: const [
        _StatCard(
          title: 'Всего животных',
          value: '—',
          icon: Icons.pets,
          color: AppColors.primary,
        ),
        _StatCard(
          title: 'Процедур сегодня',
          value: '—',
          icon: Icons.medical_services,
          color: AppColors.secondary,
        ),
        _StatCard(
          title: 'Активных геозон',
          value: '—',
          icon: Icons.fence,
          color: AppColors.info,
        ),
        _StatCard(
          title: 'Уведомлений',
          value: '—',
          icon: Icons.notifications_active,
          color: AppColors.warning,
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: color, size: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold, color: color,
                  ),
                ),
                Text(
                  title,
                  style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                  maxLines: 2,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  final String role;
  const _QuickActions({required this.role});

  @override
  Widget build(BuildContext context) {
    final actions = _getActionsForRole(role);
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.9,
      ),
      itemCount: actions.length,
      itemBuilder: (ctx, i) => _QuickActionButton(action: actions[i]),
    );
  }

  List<_QuickAction> _getActionsForRole(String role) {
    final base = [
      _QuickAction(label: 'Сканировать RFID', icon: Icons.nfc, route: '/animals/rfid-scan'),
      _QuickAction(label: 'Список животных', icon: Icons.pets, route: '/animals'),
      _QuickAction(label: 'Карта', icon: Icons.map, route: '/map'),
    ];

    if (role == 'veterinarian' || role == 'admin') {
      base.addAll([
        _QuickAction(label: 'Новый акт', icon: Icons.add_circle, route: '/procedures/create'),
        _QuickAction(label: 'Инвентарь', icon: Icons.inventory, route: '/profile'),
        _QuickAction(label: 'Геозона', icon: Icons.fence, route: '/map/geofence-editor'),
      ]);
    }

    if (role == 'inspector' || role == 'admin') {
      base.add(_QuickAction(label: 'Дашборд', icon: Icons.dashboard, route: '/dashboard'));
    }

    return base;
  }
}

class _QuickAction {
  final String label;
  final IconData icon;
  final String route;
  _QuickAction({required this.label, required this.icon, required this.route});
}

class _QuickActionButton extends StatelessWidget {
  final _QuickAction action;
  const _QuickActionButton({required this.action});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(action.route),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(action.icon, color: AppColors.primary, size: 28),
            const SizedBox(height: 6),
            Text(
              action.label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11, color: AppColors.textPrimary),
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}

class _RecentAlerts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: Load from API
    return Card(
      child: ListTile(
        leading: const Icon(Icons.info_outline, color: AppColors.info),
        title: const Text('Нет новых уведомлений'),
        subtitle: const Text('Геозонные предупреждения появятся здесь'),
      ),
    );
  }
}

class _SyncIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: Connect to sync provider
    return const Icon(Icons.cloud_done, color: Colors.white70, size: 20);
  }
}
