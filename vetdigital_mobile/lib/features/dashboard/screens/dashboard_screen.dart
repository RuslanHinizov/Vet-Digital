import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../providers/dashboard_providers.dart';

/// Government inspector dashboard screen.
/// Shows vaccination coverage, geofence violations, disease distribution.
/// Connects to /api/v1/dashboard/* endpoints via dashboardProvider.
class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedPeriod = '30d';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Аналитика'),
        actions: [
          // Period selector
          PopupMenuButton<String>(
            initialValue: _selectedPeriod,
            onSelected: (v) => setState(() => _selectedPeriod = v),
            itemBuilder: (_) => const [
              PopupMenuItem(value: '7d', child: Text('7 дней')),
              PopupMenuItem(value: '30d', child: Text('30 дней')),
              PopupMenuItem(value: '90d', child: Text('3 месяца')),
              PopupMenuItem(value: '365d', child: Text('1 год')),
            ],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_periodLabel(_selectedPeriod),
                      style: const TextStyle(fontSize: 13, color: Colors.white)),
                  const Icon(Icons.arrow_drop_down, color: Colors.white),
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.download),
            tooltip: 'Экспорт',
            onPressed: _exportReport,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          tabs: const [
            Tab(text: 'Обзор'),
            Tab(text: 'Вакцинация'),
            Tab(text: 'Геозоны'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _OverviewTab(period: _selectedPeriod),
          _VaccinationTab(period: _selectedPeriod),
          _GeofenceTab(period: _selectedPeriod),
        ],
      ),
    );
  }

  String _periodLabel(String p) {
    switch (p) {
      case '7d': return '7 дней';
      case '30d': return '30 дней';
      case '90d': return '3 мес.';
      case '365d': return '1 год';
      default: return p;
    }
  }

  void _exportReport() {
    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Экспорт отчёта', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),
            ListTile(
              leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
              title: const Text('Экспорт в PDF'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('PDF генерируется... (Phase 7)')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.table_chart, color: Colors.green),
              title: const Text('Экспорт в Excel'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Excel генерируется... (Phase 7)')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Overview Tab ─────────────────────────────────────────────────────────────

class _OverviewTab extends ConsumerWidget {
  final String period;
  const _OverviewTab({required this.period});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashState = ref.watch(dashboardProvider);
    final overview = dashState.overview;

    // Format numbers
    String fmt(int n) => n >= 1000
        ? '${(n / 1000).toStringAsFixed(1)}к'
        : n.toString();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Refresh indicator
          if (dashState.isLoading)
            const LinearProgressIndicator(),

          // KPI Cards row 1
          Row(
            children: [
              Expanded(child: _KpiCard(
                title: 'Всего животных',
                value: overview != null ? fmt(overview.totalAnimals) : '—',
                change: '+234',
                changePositive: true,
                icon: Icons.pets,
                color: AppColors.primary,
              )),
              const SizedBox(width: 12),
              Expanded(child: _KpiCard(
                title: 'Вакцинировано сегодня',
                value: overview != null ? fmt(overview.vaccinatedToday) : '—',
                change: '',
                changePositive: true,
                icon: Icons.vaccines,
                color: AppColors.success,
              )),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _KpiCard(
                title: 'Геозоны',
                value: overview != null ? overview.activeGeofences.toString() : '—',
                change: '',
                changePositive: true,
                icon: Icons.fence,
                color: AppColors.secondary,
              )),
              const SizedBox(width: 12),
              Expanded(child: _KpiCard(
                title: 'Нарушений',
                value: overview != null ? overview.geofenceViolations.toString() : '—',
                change: '',
                changePositive: false,
                icon: Icons.warning_amber,
                color: AppColors.warning,
              )),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _KpiCard(
                title: 'Ожид. подпись',
                value: overview != null ? overview.pendingDocuments.toString() : '—',
                change: '',
                changePositive: false,
                icon: Icons.draw,
                color: Colors.orange,
              )),
              const SizedBox(width: 12),
              Expanded(child: _KpiCard(
                title: 'Мало запасов',
                value: overview != null ? overview.lowStockItems.toString() : '—',
                change: '',
                changePositive: false,
                icon: Icons.inventory_2,
                color: Colors.red,
              )),
            ],
          ),
          const SizedBox(height: 20),

          // Vaccination coverage by region
          const Text('Охват вакцинацией по областям',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 12),
          _RegionCoverageChart(coverage: dashState.coverage),
          const SizedBox(height: 20),

          // Activity trend
          const Text('Активность за период',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 12),
          _ActivityTrendChart(activity: dashState.activity),
        ],
      ),
    );
  }
}

// ─── Vaccination Tab ──────────────────────────────────────────────────────────

class _VaccinationTab extends StatelessWidget {
  final String period;
  const _VaccinationTab({required this.period});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pie chart - species breakdown
          const Text('Распределение по видам',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 12),
          _SpeciesPieChart(),
          const SizedBox(height: 20),

          // Disease coverage table
          const Text('Охват по заболеваниям',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 8),
          _DiseaseCoverageTable(),
          const SizedBox(height: 20),

          // Recent acts
          const Text('Последние акты',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 8),
          _RecentActsList(),
        ],
      ),
    );
  }
}

// ─── Geofence Tab ─────────────────────────────────────────────────────────────

class _GeofenceTab extends StatelessWidget {
  final String period;
  const _GeofenceTab({required this.period});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: _KpiCard(
                title: 'Активных геозон',
                value: '124',
                change: '+8',
                changePositive: true,
                icon: Icons.fence,
                color: AppColors.geofencePasture,
              )),
              const SizedBox(width: 12),
              Expanded(child: _KpiCard(
                title: 'Нарушений',
                value: '17',
                change: '-3',
                changePositive: true,
                icon: Icons.notification_important,
                color: AppColors.danger,
              )),
            ],
          ),
          const SizedBox(height: 20),

          const Text('Нарушения по типу геозоны',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 12),
          _GeofenceViolationList(),
          const SizedBox(height: 20),

          const Text('Часто нарушаемые зоны',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 8),
          _TopViolatedZones(),
        ],
      ),
    );
  }
}

// ─── Chart Widgets ────────────────────────────────────────────────────────────

class _RegionCoverageChart extends StatelessWidget {
  final List<VaccinationCoverageData> coverage;
  const _RegionCoverageChart({this.coverage = const []});

  @override
  Widget build(BuildContext context) {
    final regions = coverage.isNotEmpty
        ? coverage
        : VaccinationCoverageData.demoList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: regions.map((r) {
            final pct = r.coveragePercent / 100;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      r.regionName.split(' ').first,
                      style: const TextStyle(fontSize: 11),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: LinearProgressIndicator(
                      value: pct,
                      backgroundColor: Colors.grey[200],
                      color: pct >= 0.8
                          ? AppColors.success
                          : pct >= 0.6
                              ? AppColors.warning
                              : AppColors.danger,
                      minHeight: 12,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 42,
                    child: Text(
                      '${r.coveragePercent.toStringAsFixed(0)}%',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: pct >= 0.8 ? AppColors.success : AppColors.warning,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _ActivityTrendChart extends StatelessWidget {
  final List<ActivityPoint> activity;
  const _ActivityTrendChart({this.activity = const []});

  @override
  Widget build(BuildContext context) {
    final points = activity.isNotEmpty ? activity : ActivityPoint.demoList();
    final spots = points.asMap().entries.map((e) =>
        FlSpot(e.key.toDouble(), e.value.proceduresCount.toDouble())).toList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 16, 16, 8),
        child: SizedBox(
          height: 180,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: 50,
                getDrawingHorizontalLine: (_) => const FlLine(
                  color: Color(0xFFEEEEEE),
                  strokeWidth: 1,
                ),
              ),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 36,
                    getTitlesWidget: (v, _) => Text(v.toInt().toString(),
                        style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (v, _) {
                      const days = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
                      if (v.toInt() < days.length) {
                        return Text(days[v.toInt()],
                            style: const TextStyle(fontSize: 10, color: AppColors.textSecondary));
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  color: AppColors.primary,
                  barWidth: 2.5,
                  belowBarData: BarAreaData(
                    show: true,
                    color: AppColors.primary.withOpacity(0.1),
                  ),
                  dotData: const FlDotData(show: false),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SpeciesPieChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sections = [
      PieChartSectionData(value: 45, title: 'КРС\n45%', color: AppColors.primary, radius: 70),
      PieChartSectionData(value: 30, title: 'МРС\n30%', color: AppColors.secondary, radius: 70),
      PieChartSectionData(value: 15, title: 'Лош.\n15%', color: AppColors.success, radius: 70),
      PieChartSectionData(value: 10, title: 'Проч.\n10%', color: AppColors.textSecondary, radius: 70),
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 200,
          child: PieChart(
            PieChartData(
              sections: sections,
              sectionsSpace: 2,
              centerSpaceRadius: 0,
            ),
          ),
        ),
      ),
    );
  }
}

class _DiseaseCoverageTable extends StatelessWidget {
  final _data = const [
    {'disease': 'Ящур', 'target': 48392, 'done': 43120, 'coverage': 89.1},
    {'disease': 'Бруцеллез', 'target': 35000, 'done': 28400, 'coverage': 81.1},
    {'disease': 'Сибирская язва', 'target': 48392, 'done': 40890, 'coverage': 84.5},
    {'disease': 'Туберкулез (тест)', 'target': 48392, 'done': 32100, 'coverage': 66.3},
    {'disease': 'Нодулярный дерматит', 'target': 22000, 'done': 18700, 'coverage': 85.0},
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: _data.map((d) {
            final coverage = d['coverage'] as double;
            return ListTile(
              dense: true,
              title: Text(d['disease'] as String, style: const TextStyle(fontSize: 13)),
              subtitle: LinearProgressIndicator(
                value: coverage / 100,
                backgroundColor: Colors.grey[200],
                color: coverage >= 80 ? AppColors.success : AppColors.warning,
                minHeight: 6,
                borderRadius: BorderRadius.circular(3),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('${coverage.toStringAsFixed(1)}%',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: coverage >= 80 ? AppColors.success : AppColors.warning,
                      )),
                  Text('${d['done']} / ${d['target']}',
                      style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _RecentActsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          _ActTile('АКТ-2025-045', 'Вакцинация • Ящур', '120 гол.', AppColors.success),
          _ActTile('АКТ-2025-044', 'Аллерг. тест • Туберкулез', '48 гол.', AppColors.warning),
          _ActTile('АКТ-2025-043', 'Вакцинация • Бруцеллез', '85 гол.', AppColors.success),
        ],
      ),
    );
  }
}

class _ActTile extends StatelessWidget {
  final String number;
  final String description;
  final String count;
  final Color color;
  const _ActTile(this.number, this.description, this.count, this.color);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: Container(
        width: 8,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      title: Text(number, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
      subtitle: Text(description, style: const TextStyle(fontSize: 11)),
      trailing: Text(count, style: const TextStyle(fontSize: 12)),
    );
  }
}

class _GeofenceViolationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final types = [
      {'type': 'Карантинная зона', 'count': 8, 'color': AppColors.geofenceQuarantine},
      {'type': 'Запрет. зона', 'count': 5, 'color': AppColors.geofenceRestricted},
      {'type': 'Пастбище', 'count': 3, 'color': AppColors.geofencePasture},
      {'type': 'Ферма', 'count': 1, 'color': AppColors.geofenceFarm},
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: types.map((t) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: t['color'] as Color,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(child: Text(t['type'] as String, style: const TextStyle(fontSize: 13))),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: (t['color'] as Color).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${t['count']} наруш.',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: t['color'] as Color,
                    ),
                  ),
                ),
              ],
            ),
          )).toList(),
        ),
      ),
    );
  }
}

class _TopViolatedZones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          _ZoneTile('Карантин-Алматы-01', 'Карантинная зона', 5),
          _ZoneTile('ЗЗ-ВКО-Красный мост', 'Запрет. зона', 3),
          _ZoneTile('Пастбище-Жамбыл-03', 'Пастбище', 2),
        ],
      ),
    );
  }
}

class _ZoneTile extends StatelessWidget {
  final String name;
  final String type;
  final int count;
  const _ZoneTile(this.name, this.type, this.count);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: const Icon(Icons.fence, color: AppColors.danger, size: 20),
      title: Text(name, style: const TextStyle(fontSize: 13)),
      subtitle: Text(type, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
      trailing: Chip(
        label: Text('$count раз', style: const TextStyle(fontSize: 11)),
        backgroundColor: AppColors.danger.withOpacity(0.1),
        labelStyle: const TextStyle(color: AppColors.danger),
        visualDensity: VisualDensity.compact,
      ),
    );
  }
}

// ─── Shared widgets ───────────────────────────────────────────────────────────

class _KpiCard extends StatelessWidget {
  final String title;
  final String value;
  final String change;
  final bool changePositive;
  final IconData icon;
  final Color color;

  const _KpiCard({
    required this.title,
    required this.value,
    required this.change,
    required this.changePositive,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 18),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: (changePositive ? AppColors.success : AppColors.danger).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    change,
                    style: TextStyle(
                      fontSize: 10,
                      color: changePositive ? AppColors.success : AppColors.danger,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(value,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
            Text(title, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}
