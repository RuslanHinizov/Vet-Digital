import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../providers/auth_providers.dart';

/// User profile and settings screen.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Профиль')),
      body: ListView(
        children: [
          // Profile header
          Container(
            color: AppColors.primary,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  child: const Icon(Icons.person, color: Colors.white, size: 36),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Сейтқали Арман Мұратұлы',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Ветеринарный врач',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'ИИН: 850101300123',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.white),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Organization
          _SettingsSection(
            title: 'Организация',
            items: [
              _SettingsTile(
                icon: Icons.business,
                title: 'Министерство сельского хозяйства',
                subtitle: 'Алматинское районное управление',
              ),
              _SettingsTile(
                icon: Icons.location_on,
                title: 'Регион',
                subtitle: 'Алматы облысы, Карасайский район',
              ),
            ],
          ),

          // EDS Certificate
          _SettingsSection(
            title: 'ЭЦП сертификат',
            items: [
              _SettingsTile(
                icon: Icons.verified_user,
                title: 'Сертификат',
                subtitle: 'Действителен до 15.03.2026',
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text('Активен', style: TextStyle(color: AppColors.success, fontSize: 11)),
                ),
              ),
              _ActionTile(
                icon: Icons.refresh,
                title: 'Обновить сертификат',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Перенаправление на NCALayer...')),
                  );
                },
              ),
            ],
          ),

          // Language settings
          _SettingsSection(
            title: 'Настройки',
            items: [
              _LanguageSelector(),
              _ActionTile(
                icon: Icons.notifications,
                title: 'Уведомления',
                onTap: () {},
                trailing: const Icon(Icons.chevron_right),
              ),
              _ActionTile(
                icon: Icons.wifi_off,
                title: 'Офлайн режим',
                onTap: () {},
                trailing: const Icon(Icons.chevron_right),
              ),
              _ActionTile(
                icon: Icons.lock,
                title: 'Изменить PIN-код',
                onTap: () {},
                trailing: const Icon(Icons.chevron_right),
              ),
            ],
          ),

          // App info
          _SettingsSection(
            title: 'О приложении',
            items: [
              _SettingsTile(
                icon: Icons.info_outline,
                title: 'Версия',
                subtitle: 'VetDigital 1.0.0 (build 1)',
              ),
              _SettingsTile(
                icon: Icons.policy,
                title: 'Политика конфиденциальности',
                subtitle: 'gov.kz',
              ),
            ],
          ),

          // Logout
          Padding(
            padding: const EdgeInsets.all(16),
            child: OutlinedButton.icon(
              onPressed: () => _confirmLogout(context, ref),
              icon: const Icon(Icons.logout, color: AppColors.danger),
              label: const Text('Выйти из аккаунта', style: TextStyle(color: AppColors.danger)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.danger),
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  void _confirmLogout(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Выход'),
        content: const Text('Вы уверены, что хотите выйти?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(authProvider.notifier).logout();
            },
            child: const Text('Выйти', style: TextStyle(color: AppColors.danger)),
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> items;
  const _SettingsSection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
              letterSpacing: 0.8,
            ),
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: items),
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary, size: 20),
      title: Text(title, style: const TextStyle(fontSize: 14)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      trailing: trailing,
      dense: true,
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Widget? trailing;
  const _ActionTile({required this.icon, required this.title, required this.onTap, this.trailing});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary, size: 20),
      title: Text(title, style: const TextStyle(fontSize: 14)),
      trailing: trailing ?? const Icon(Icons.chevron_right, color: AppColors.textSecondary),
      onTap: onTap,
      dense: true,
    );
  }
}

class _LanguageSelector extends StatefulWidget {
  @override
  State<_LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<_LanguageSelector> {
  String _lang = 'ru';

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.language, color: AppColors.primary, size: 20),
      title: const Text('Язык интерфейса', style: TextStyle(fontSize: 14)),
      trailing: DropdownButton<String>(
        value: _lang,
        underline: const SizedBox.shrink(),
        isDense: true,
        items: const [
          DropdownMenuItem(value: 'ru', child: Text('Русский')),
          DropdownMenuItem(value: 'kk', child: Text('Қазақша')),
          DropdownMenuItem(value: 'en', child: Text('English')),
        ],
        onChanged: (v) => setState(() => _lang = v!),
      ),
      dense: true,
    );
  }
}
