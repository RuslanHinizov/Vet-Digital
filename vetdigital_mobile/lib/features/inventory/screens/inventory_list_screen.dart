import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// Inventory management screen for vaccines, syringes, needles, cotton, alcohol.
/// Based on Excel template Без названия (3).xls (расходные материалы).
class InventoryListScreen extends StatefulWidget {
  const InventoryListScreen({super.key});

  @override
  State<InventoryListScreen> createState() => _InventoryListScreenState();
}

class _InventoryListScreenState extends State<InventoryListScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Demo inventory data matching inventory_items model
  final List<Map<String, dynamic>> _items = [
    {
      'id': 'inv-001',
      'name': 'Вакцина против ящура ARRIAH FMD',
      'category': 'vaccine',
      'unit': 'доза',
      'quantity': 1200,
      'min_quantity': 500,
      'series': '2024-03',
      'expiry_date': '2025-09-01',
      'manufacturer': 'ФГБУ «ВНИИЗЖ»',
    },
    {
      'id': 'inv-002',
      'name': 'Вакцина бруцеллезная (Rev-1)',
      'category': 'vaccine',
      'unit': 'доза',
      'quantity': 280,
      'min_quantity': 300,
      'series': '2024-01',
      'expiry_date': '2025-06-15',
      'manufacturer': 'РГП «НВЦ»',
    },
    {
      'id': 'inv-003',
      'name': 'Шприц 5 мл',
      'category': 'syringe',
      'unit': 'шт.',
      'quantity': 3500,
      'min_quantity': 1000,
      'series': null,
      'expiry_date': null,
      'manufacturer': 'Becton Dickinson',
    },
    {
      'id': 'inv-004',
      'name': 'Игла 0.8×40 мм',
      'category': 'needle',
      'unit': 'шт.',
      'quantity': 4000,
      'min_quantity': 2000,
      'series': null,
      'expiry_date': null,
      'manufacturer': 'Sterican',
    },
    {
      'id': 'inv-005',
      'name': 'Вата медицинская',
      'category': 'cotton',
      'unit': 'г',
      'quantity': 1500,
      'min_quantity': 500,
      'series': null,
      'expiry_date': null,
      'manufacturer': 'ГЕЛИОС',
    },
    {
      'id': 'inv-006',
      'name': 'Спирт 70% медицинский',
      'category': 'alcohol',
      'unit': 'мл',
      'quantity': 5000,
      'min_quantity': 1000,
      'series': null,
      'expiry_date': null,
      'manufacturer': 'ФармХолдинг',
    },
    {
      'id': 'inv-007',
      'name': 'ППД туберкулин для млекопитающих',
      'category': 'allergen',
      'unit': 'доза',
      'quantity': 450,
      'min_quantity': 200,
      'series': '2024-05',
      'expiry_date': '2025-11-30',
      'manufacturer': 'Всероссийский НИПИ ветеринарной санитарии',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _lowStock =>
      _items.where((i) => (i['quantity'] as int) < (i['min_quantity'] as int)).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Склад материалов'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Пополнить склад',
            onPressed: () => _showAddDialog(context),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          tabs: [
            const Tab(text: 'Все материалы'),
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Заканчиваются'),
                  if (_lowStock.isNotEmpty) ...[
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                      decoration: BoxDecoration(
                        color: AppColors.danger,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${_lowStock.length}',
                        style: const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _AllItemsList(items: _items, onConsume: _showConsumeDialog),
          _LowStockList(items: _lowStock, onOrder: _showOrderDialog),
        ],
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => const _AddInventorySheet(),
    );
  }

  void _showConsumeDialog(Map<String, dynamic> item) {
    final qtyController = TextEditingController(text: '1');
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Списать: ${item['name']}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Доступно: ${item['quantity']} ${item['unit']}'),
            const SizedBox(height: 12),
            TextField(
              controller: qtyController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Количество (${item['unit']})',
                isDense: true,
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Отмена')),
          ElevatedButton(
            onPressed: () {
              final qty = int.tryParse(qtyController.text) ?? 0;
              if (qty > 0 && qty <= (item['quantity'] as int)) {
                setState(() {
                  final idx = _items.indexWhere((i) => i['id'] == item['id']);
                  _items[idx]['quantity'] = (item['quantity'] as int) - qty;
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Списано: $qty ${item['unit']}')),
                );
              }
            },
            child: const Text('Списать'),
          ),
        ],
      ),
    );
  }

  void _showOrderDialog(Map<String, dynamic> item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Заявка на пополнение ${item['name']} отправлена (Phase 5)')),
    );
  }
}

class _AllItemsList extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final ValueChanged<Map<String, dynamic>> onConsume;
  const _AllItemsList({required this.items, required this.onConsume});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (_, i) => _InventoryCard(item: items[i], onConsume: onConsume),
    );
  }
}

class _LowStockList extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final ValueChanged<Map<String, dynamic>> onOrder;
  const _LowStockList({required this.items, required this.onOrder});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle_outline, size: 48, color: AppColors.success),
            SizedBox(height: 8),
            Text('Все материалы в норме', style: TextStyle(color: AppColors.success)),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (_, i) => _LowStockCard(item: items[i], onOrder: onOrder),
    );
  }
}

class _InventoryCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final ValueChanged<Map<String, dynamic>> onConsume;
  const _InventoryCard({required this.item, required this.onConsume});

  @override
  Widget build(BuildContext context) {
    final qty = item['quantity'] as int;
    final minQty = item['min_quantity'] as int;
    final isLow = qty < minQty;
    final isExpiringSoon = _isExpiringSoon(item['expiry_date']);

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _CategoryIcon(category: item['category']),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                      if (item['manufacturer'] != null)
                        Text(item['manufacturer'], style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
                if (isLow)
                  const Icon(Icons.warning_amber, color: AppColors.warning, size: 18),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$qty ${item['unit']}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isLow ? AppColors.warning : AppColors.primary,
                        ),
                      ),
                      Text('Мин: $minQty ${item['unit']}',
                          style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
                if (item['series'] != null) ...[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Серия: ${item['series']}',
                          style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                      if (item['expiry_date'] != null)
                        Text(
                          'До: ${item['expiry_date']}',
                          style: TextStyle(
                            fontSize: 11,
                            color: isExpiringSoon ? AppColors.warning : AppColors.textSecondary,
                            fontWeight: isExpiringSoon ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                    ],
                  ),
                ],
              ],
            ),
            const SizedBox(height: 8),
            // Progress bar
            LinearProgressIndicator(
              value: qty / (minQty * 3).toDouble().clamp(1, double.infinity),
              backgroundColor: Colors.grey[200],
              color: isLow ? AppColors.warning : AppColors.success,
              minHeight: 6,
              borderRadius: BorderRadius.circular(3),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () => onConsume(item),
                icon: const Icon(Icons.remove_circle_outline, size: 16),
                label: const Text('Списать', style: TextStyle(fontSize: 12)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isExpiringSoon(String? date) {
    if (date == null) return false;
    try {
      final parts = date.split('-');
      final expiry = DateTime(int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
      return expiry.difference(DateTime.now()).inDays < 90;
    } catch (_) {
      return false;
    }
  }
}

class _LowStockCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final ValueChanged<Map<String, dynamic>> onOrder;
  const _LowStockCard({required this.item, required this.onOrder});

  @override
  Widget build(BuildContext context) {
    final qty = item['quantity'] as int;
    final minQty = item['min_quantity'] as int;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: _CategoryIcon(category: item['category']),
        title: Text(item['name'], style: const TextStyle(fontSize: 13)),
        subtitle: Text(
          'Осталось: $qty ${item['unit']} • Норма: $minQty ${item['unit']}',
          style: const TextStyle(fontSize: 11, color: AppColors.warning),
        ),
        trailing: ElevatedButton(
          onPressed: () => onOrder(item),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            textStyle: const TextStyle(fontSize: 12),
          ),
          child: const Text('Заявка'),
        ),
      ),
    );
  }
}

class _CategoryIcon extends StatelessWidget {
  final String category;
  const _CategoryIcon({required this.category});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;
    switch (category) {
      case 'vaccine':
        icon = Icons.vaccines;
        color = AppColors.success;
        break;
      case 'allergen':
        icon = Icons.biotech;
        color = AppColors.warning;
        break;
      case 'syringe':
        icon = Icons.colorize;
        color = AppColors.info;
        break;
      case 'needle':
        icon = Icons.straighten;
        color = AppColors.secondary;
        break;
      case 'cotton':
        icon = Icons.spa;
        color = Colors.grey;
        break;
      case 'alcohol':
        icon = Icons.local_drink;
        color = Colors.blueGrey;
        break;
      default:
        icon = Icons.inventory_2;
        color = AppColors.primary;
    }
    return CircleAvatar(
      radius: 20,
      backgroundColor: color.withOpacity(0.1),
      child: Icon(icon, color: color, size: 18),
    );
  }
}

class _AddInventorySheet extends StatefulWidget {
  const _AddInventorySheet();

  @override
  State<_AddInventorySheet> createState() => _AddInventorySheetState();
}

class _AddInventorySheetState extends State<_AddInventorySheet> {
  final _nameController = TextEditingController();
  final _qtyController = TextEditingController();
  String _category = 'vaccine';
  String _unit = 'доза';

  static const _categories = [
    ('vaccine', 'Вакцина'),
    ('allergen', 'Аллерген'),
    ('syringe', 'Шприц'),
    ('needle', 'Игла'),
    ('cotton', 'Вата'),
    ('alcohol', 'Спирт'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).viewInsets.bottom + 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Добавить на склад',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _category,
            decoration: const InputDecoration(labelText: 'Категория', isDense: true, border: OutlineInputBorder()),
            items: _categories.map((c) => DropdownMenuItem(value: c.$1, child: Text(c.$2))).toList(),
            onChanged: (v) => setState(() => _category = v!),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Наименование', isDense: true, border: OutlineInputBorder()),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _qtyController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Количество', isDense: true, border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 100,
                child: DropdownButtonFormField<String>(
                  value: _unit,
                  decoration: const InputDecoration(labelText: 'Ед.', isDense: true, border: OutlineInputBorder()),
                  items: const [
                    DropdownMenuItem(value: 'доза', child: Text('доза')),
                    DropdownMenuItem(value: 'шт.', child: Text('шт.')),
                    DropdownMenuItem(value: 'мл', child: Text('мл')),
                    DropdownMenuItem(value: 'г', child: Text('г')),
                  ],
                  onChanged: (v) => setState(() => _unit = v!),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Добавлено: ${_nameController.text} (Phase 4 API)')),
                );
              },
              child: const Text('Добавить'),
            ),
          ),
        ],
      ),
    );
  }
}
