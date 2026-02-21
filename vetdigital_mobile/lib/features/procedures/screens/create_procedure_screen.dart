import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';

/// 4-step veterinary procedure act creation form.
///
/// Step 1: Basic info (act number, date, territory, responsible specialist)
/// Step 2: Animal selection (species, sex/age counts, owner info, registry table)
/// Step 3: Vaccine/allergy test info (drug name, manufacturer, series, dose)
/// Step 4: Preview + EDS signature
///
/// Mirrors the Excel templates from КМД (ветеринарный процедурный акт).
class CreateProcedureScreen extends StatefulWidget {
  const CreateProcedureScreen({super.key});

  @override
  State<CreateProcedureScreen> createState() => _CreateProcedureScreenState();
}

class _CreateProcedureScreenState extends State<CreateProcedureScreen> {
  int _currentStep = 0;
  final PageController _pageController = PageController();

  // Step 1 - Basic info
  final _actNumberController = TextEditingController();
  DateTime _actDate = DateTime.now();
  String _regionKato = '';
  final _settlementController = TextEditingController();
  final _specialistController = TextEditingController();
  final _participantsController = TextEditingController();
  String _procedureType = 'vaccination';

  // Step 2 - Animals
  String _selectedSpecies = 'cattle';
  final _maleSheepController = TextEditingController(text: '0');
  final _femaleSheepController = TextEditingController(text: '0');
  final _youngController = TextEditingController(text: '0');
  final _ownerIinController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final List<Map<String, dynamic>> _animalRows = [];

  // Step 3 - Drug/vaccine info
  final _diseaseNameController = TextEditingController();
  final _vaccineNameController = TextEditingController();
  final _manufacturerController = TextEditingController();
  DateTime? _productionDate;
  final _seriesController = TextEditingController();
  final _stateControlController = TextEditingController();
  String _injectionMethod = 'subcutaneous';
  final _doseAdultController = TextEditingController(text: '2.0');
  final _doseYoungController = TextEditingController(text: '1.0');
  // Allergy test specific
  final _allergenNameController = TextEditingController();
  final _readingHoursController = TextEditingController(text: '72');

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Новый акт • Шаг ${_currentStep + 1}/4'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: _confirmDiscard,
        ),
        actions: [
          if (_currentStep > 0)
            TextButton(
              onPressed: _previousStep,
              child: const Text('Назад', style: TextStyle(color: Colors.white)),
            ),
        ],
      ),
      body: Column(
        children: [
          // Progress indicator
          _StepProgressBar(currentStep: _currentStep),

          // Form pages
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _Step1BasicInfo(this),
                _Step2Animals(this),
                _Step3DrugInfo(this),
                _Step4Preview(this),
              ],
            ),
          ),

          // Bottom navigation
          _BottomNav(
            currentStep: _currentStep,
            onNext: _nextStep,
            onSaveDraft: _saveDraft,
          ),
        ],
      ),
    );
  }

  void _nextStep() {
    if (_currentStep < 3) {
      if (!_validateCurrentStep()) return;
      setState(() => _currentStep++);
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _submitAct();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  bool _validateCurrentStep() {
    switch (_currentStep) {
      case 0:
        if (_actNumberController.text.isEmpty) {
          _showError('Введите номер акта');
          return false;
        }
        if (_specialistController.text.isEmpty) {
          _showError('Введите ФИО ответственного специалиста');
          return false;
        }
        return true;
      case 1:
        final total = (int.tryParse(_maleSheepController.text) ?? 0) +
            (int.tryParse(_femaleSheepController.text) ?? 0) +
            (int.tryParse(_youngController.text) ?? 0);
        if (total == 0) {
          _showError('Укажите количество животных');
          return false;
        }
        return true;
      case 2:
        if (_diseaseNameController.text.isEmpty) {
          _showError('Введите название болезни');
          return false;
        }
        if (_procedureType == 'vaccination' && _vaccineNameController.text.isEmpty) {
          _showError('Введите название вакцины');
          return false;
        }
        return true;
      default:
        return true;
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: AppColors.danger),
    );
  }

  void _saveDraft() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Черновик сохранён')),
    );
  }

  void _submitAct() {
    // TODO: Phase 3 - POST to /api/v1/procedures
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Акт создан'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: AppColors.success, size: 48),
            const SizedBox(height: 12),
            Text(
              'Акт ${_actNumberController.text} успешно создан.\n'
              'Отправьте на подпись ЭЦП для завершения.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/procedures');
            },
            child: const Text('К списку актов'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Navigate to EDS signing
            },
            child: const Text('Подписать ЭЦП'),
          ),
        ],
      ),
    );
  }

  void _confirmDiscard() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Отменить создание?'),
        content: const Text('Несохранённые данные будут потеряны.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Нет'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/procedures');
            },
            child: const Text('Да, отменить', style: TextStyle(color: AppColors.danger)),
          ),
        ],
      ),
    );
  }

  int get totalAnimals {
    return (int.tryParse(_maleSheepController.text) ?? 0) +
        (int.tryParse(_femaleSheepController.text) ?? 0) +
        (int.tryParse(_youngController.text) ?? 0);
  }
}

// ─── Step Progress Bar ───────────────────────────────────────────────────────

class _StepProgressBar extends StatelessWidget {
  final int currentStep;
  const _StepProgressBar({required this.currentStep});

  static const _steps = ['Основное', 'Животные', 'Препарат', 'Подпись'];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: List.generate(_steps.length * 2 - 1, (i) {
          if (i.isOdd) {
            // Connector line
            final stepIndex = i ~/ 2;
            return Expanded(
              child: Container(
                height: 2,
                color: stepIndex < currentStep ? AppColors.primary : Colors.grey[300],
              ),
            );
          }
          final stepIndex = i ~/ 2;
          final done = stepIndex < currentStep;
          final active = stepIndex == currentStep;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: done || active ? AppColors.primary : Colors.grey[300],
                ),
                child: Center(
                  child: done
                      ? const Icon(Icons.check, color: Colors.white, size: 14)
                      : Text('${stepIndex + 1}',
                          style: TextStyle(
                            color: active ? Colors.white : Colors.grey[600],
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          )),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                _steps[stepIndex],
                style: TextStyle(
                  fontSize: 9,
                  color: active ? AppColors.primary : AppColors.textSecondary,
                  fontWeight: active ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

// ─── Step 1: Basic Info ───────────────────────────────────────────────────────

class _Step1BasicInfo extends StatelessWidget {
  final _CreateProcedureScreenState s;
  const _Step1BasicInfo(this.s);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionLabel('Идентификация акта'),
          _FormField(
            label: 'Номер акта *',
            controller: s._actNumberController,
            hint: 'АКТ-2025-XXX',
          ),
          const SizedBox(height: 12),
          _DatePickerField(
            label: 'Дата составления *',
            value: s._actDate,
            onChanged: (d) => s.setState(() => s._actDate = d),
          ),
          const SizedBox(height: 16),
          const _SectionLabel('Место проведения'),
          _FormField(
            label: 'Населённый пункт *',
            controller: s._settlementController,
            hint: 'Алматы, с. Каскелен...',
          ),
          const SizedBox(height: 12),
          const Text('Тип процедуры *', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
          const SizedBox(height: 6),
          _ProcedureTypeSelector(
            value: s._procedureType,
            onChanged: (v) => s.setState(() => s._procedureType = v),
          ),
          const SizedBox(height: 16),
          const _SectionLabel('Ответственные лица'),
          _FormField(
            label: 'ФИО ответственного специалиста *',
            controller: s._specialistController,
            hint: 'Иванов Иван Иванович',
          ),
          const SizedBox(height: 12),
          _FormField(
            label: 'Участники (через запятую)',
            controller: s._participantsController,
            hint: 'Петров А.А., Сидоров Б.Б.',
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}

// ─── Step 2: Animals ──────────────────────────────────────────────────────────

class _Step2Animals extends StatelessWidget {
  final _CreateProcedureScreenState s;
  const _Step2Animals(this.s);

  static const _speciesOptions = [
    ('cattle', 'КРС', Icons.local_activity),
    ('sheep', 'МРС', Icons.local_activity),
    ('horses', 'Лошади', Icons.local_activity),
    ('camels', 'Верблюды', Icons.local_activity),
    ('pigs', 'Свиньи', Icons.local_activity),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionLabel('Вид животных'),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _speciesOptions.map((opt) {
                final selected = s._selectedSpecies == opt.$1;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => s.setState(() => s._selectedSpecies = opt.$1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: selected ? AppColors.primary : Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: selected ? AppColors.primary : Colors.grey[300]!,
                        ),
                      ),
                      child: Text(
                        opt.$2,
                        style: TextStyle(
                          color: selected ? Colors.white : AppColors.textPrimary,
                          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),
          const _SectionLabel('Количество по полу и возрасту'),
          Row(
            children: [
              Expanded(
                child: _CountField(label: 'Самцы (гол.)', controller: s._maleSheepController, onChanged: (_) => s.setState(() {})),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _CountField(label: 'Самки (гол.)', controller: s._femaleSheepController, onChanged: (_) => s.setState(() {})),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _CountField(label: 'Молодняк (гол.)', controller: s._youngController, onChanged: (_) => s.setState(() {})),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text('Итого: ', style: TextStyle(color: AppColors.textSecondary)),
              Text(
                '${s.totalAnimals} голов',
                style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const _SectionLabel('Владелец животных'),
          _FormField(
            label: 'ИИН/БИН владельца',
            controller: s._ownerIinController,
            hint: '000000000000',
            keyboardType: TextInputType.number,
            maxLength: 12,
            suffix: IconButton(
              icon: const Icon(Icons.search, size: 18),
              onPressed: () {
                // TODO: lookup owner by IIN from API
              },
            ),
          ),
          const SizedBox(height: 8),
          _FormField(
            label: 'ФИО / наименование организации',
            controller: s._ownerNameController,
            hint: 'Ибраев Нурлан Сейтқалиевич',
          ),
          const SizedBox(height: 16),
          // Animal registry table (from Excel template Без названия (5).xls)
          const _SectionLabel('Таблица учёта животных'),
          if (s._animalRows.isEmpty)
            OutlinedButton.icon(
              onPressed: () => _addAnimalRow(context),
              icon: const Icon(Icons.add),
              label: const Text('Добавить запись'),
            )
          else ...[
            _AnimalRegistryTable(rows: s._animalRows, onRemove: (i) => s.setState(() => s._animalRows.removeAt(i))),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () => _addAnimalRow(context),
              icon: const Icon(Icons.add),
              label: const Text('Добавить животное'),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _addAnimalRow(BuildContext context) async {
    final idController = TextEditingController();
    final colorController = TextEditingController();
    String sex = 'female';
    String age = 'adult';

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Животное'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: idController,
              decoration: const InputDecoration(labelText: 'Идентификационный номер', isDense: true),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: colorController,
              decoration: const InputDecoration(labelText: 'Масть/цвет', isDense: true),
            ),
            const SizedBox(height: 8),
            StatefulBuilder(builder: (ctx, setLocal) => Row(
              children: [
                const Text('Пол: ', style: TextStyle(fontSize: 13)),
                DropdownButton<String>(
                  value: sex,
                  isDense: true,
                  items: const [
                    DropdownMenuItem(value: 'male', child: Text('Самец')),
                    DropdownMenuItem(value: 'female', child: Text('Самка')),
                  ],
                  onChanged: (v) => setLocal(() => sex = v!),
                ),
                const SizedBox(width: 16),
                const Text('Возраст: ', style: TextStyle(fontSize: 13)),
                DropdownButton<String>(
                  value: age,
                  isDense: true,
                  items: const [
                    DropdownMenuItem(value: 'adult', child: Text('Взрослое')),
                    DropdownMenuItem(value: 'young', child: Text('Молодняк')),
                  ],
                  onChanged: (v) => setLocal(() => age = v!),
                ),
              ],
            )),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Отмена')),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, {
              'identification_no': idController.text,
              'color': colorController.text,
              'sex': sex,
              'age_group': age,
            }),
            child: const Text('Добавить'),
          ),
        ],
      ),
    );

    if (result != null) {
      s.setState(() => s._animalRows.add(result));
    }
  }
}

// ─── Step 3: Drug/Vaccine Info ────────────────────────────────────────────────

class _Step3DrugInfo extends StatelessWidget {
  final _CreateProcedureScreenState s;
  const _Step3DrugInfo(this.s);

  static const _injectionMethods = [
    ('subcutaneous', 'Подкожно'),
    ('intramuscular', 'Внутримышечно'),
    ('intradermal', 'Внутрикожно'),
    ('oral', 'Перорально'),
    ('nasal', 'Интраназально'),
  ];

  @override
  Widget build(BuildContext context) {
    final isVaccination = s._procedureType == 'vaccination';
    final isAllergyTest = s._procedureType == 'allergy_test';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionLabel('Заболевание'),
          _FormField(
            label: 'Название болезни *',
            controller: s._diseaseNameController,
            hint: isAllergyTest ? 'Туберкулез' : 'Ящур, Бруцеллез...',
          ),
          const SizedBox(height: 16),

          if (isVaccination) ...[
            const _SectionLabel('Вакцина / биопрепарат'),
            _FormField(
              label: 'Название вакцины *',
              controller: s._vaccineNameController,
              hint: 'ARRIAH FMD O/A/Asia-1',
            ),
          ],
          if (isAllergyTest) ...[
            const _SectionLabel('Аллерген'),
            _FormField(
              label: 'Название аллергена *',
              controller: s._allergenNameController,
              hint: 'ППД туберкулин для млекопитающих',
            ),
          ],

          const SizedBox(height: 12),
          _FormField(
            label: 'Производитель',
            controller: s._manufacturerController,
            hint: 'ФГБУ «ВНИИЗЖ» (Россия)',
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _DatePickerField(
                  label: 'Дата производства',
                  value: s._productionDate,
                  onChanged: (d) => s.setState(() => s._productionDate = d),
                  allowNull: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _FormField(
                  label: 'Серия',
                  controller: s._seriesController,
                  hint: '2024-01',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _FormField(
                  label: '№ гос. контроля',
                  controller: s._stateControlController,
                  hint: 'ГК-12345',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          const _SectionLabel('Способ введения'),
          DropdownButtonFormField<String>(
            value: s._injectionMethod,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
            ),
            items: _injectionMethods.map((m) => DropdownMenuItem(
              value: m.$1,
              child: Text(m.$2),
            )).toList(),
            onChanged: (v) => s.setState(() => s._injectionMethod = v!),
          ),
          const SizedBox(height: 16),

          const _SectionLabel('Дозировка'),
          Row(
            children: [
              Expanded(
                child: _FormField(
                  label: 'Взрослые (мл)',
                  controller: s._doseAdultController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _FormField(
                  label: 'Молодняк (мл)',
                  controller: s._doseYoungController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
            ],
          ),

          if (isAllergyTest) ...[
            const SizedBox(height: 16),
            const _SectionLabel('Параметры аллерг. теста'),
            _FormField(
              label: 'Срок учёта (часов)',
              controller: s._readingHoursController,
              keyboardType: TextInputType.number,
              hint: '72',
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.info.withOpacity(0.08),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Результаты аллергического теста (толщина кожной складки, разница мм) '
                'вносятся в таблицу животных на Шаге 2.',
                style: TextStyle(fontSize: 12, color: AppColors.info),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ─── Step 4: Preview + EDS Signature ─────────────────────────────────────────

class _Step4Preview extends StatelessWidget {
  final _CreateProcedureScreenState s;
  const _Step4Preview(this.s);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Preview card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.description, color: AppColors.primary),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          s._actNumberController.text.isEmpty
                              ? 'Акт (без номера)'
                              : s._actNumberController.text,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  _PreviewRow('Дата', '${s._actDate.day}.${s._actDate.month}.${s._actDate.year}'),
                  _PreviewRow('Тип', s._procedureType == 'vaccination' ? 'Вакцинация' : 'Аллерг. тест'),
                  _PreviewRow('Болезнь', s._diseaseNameController.text),
                  _PreviewRow('Специалист', s._specialistController.text),
                  _PreviewRow('Вид', s._selectedSpecies),
                  _PreviewRow('Всего животных', '${s.totalAnimals} голов'),
                  if (s._procedureType == 'vaccination')
                    _PreviewRow('Вакцина', s._vaccineNameController.text),
                  _PreviewRow('Серия', s._seriesController.text),
                  _PreviewRow('Дозировка', '${s._doseAdultController.text} мл / ${s._doseYoungController.text} мл (молодняк)'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Expendable materials summary (from Excel template Без названия (3).xls)
          const _SectionLabel('Сводка расходных материалов'),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  _MaterialRow('Вакцина / аллерген', '${s.totalAnimals} дозы'),
                  _MaterialRow('Шприцы', '${s.totalAnimals} шт.'),
                  _MaterialRow('Иглы', '${s.totalAnimals * 2} шт.'),
                  _MaterialRow('Вата', '${(s.totalAnimals * 0.5).ceil()} г'),
                  _MaterialRow('Спирт 70%', '${(s.totalAnimals * 3).ceil()} мл'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Signature section
          const _SectionLabel('Подписи'),

          // Owner signatures (from Excel template Без названия (6).xls)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Подпись владельца животных',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                if (s._ownerNameController.text.isNotEmpty)
                  Text(s._ownerNameController.text,
                      style: const TextStyle(color: AppColors.textSecondary)),
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  onPressed: () => _requestOwnerSignature(context),
                  icon: const Icon(Icons.draw, size: 16),
                  label: const Text('Запросить подпись владельца'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Veterinarian EDS signature
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.05),
              border: Border.all(color: AppColors.primary.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('ЭЦП ветеринара',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.primary)),
                const SizedBox(height: 4),
                const Text(
                  'Документ будет подписан вашим ЭЦП сертификатом через eGov Mobile. '
                  'QR-код для подписания будет отображён после создания акта.',
                  style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.security, color: AppColors.primary, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      s._specialistController.text.isEmpty
                          ? 'Специалист не указан'
                          : s._specialistController.text,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  void _requestOwnerSignature(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Подпись владельца'),
        content: const Text(
          'Владелец может подписать акт:\n'
          '1. Через eGov Mobile (QR-код)\n'
          '2. Бумажная подпись (фото)\n'
          '3. Позже (при печати)',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Позже')),
          ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('QR подпись')),
        ],
      ),
    );
  }
}

// ─── Bottom Navigation ─────────────────────────────────────────────────────────

class _BottomNav extends StatelessWidget {
  final int currentStep;
  final VoidCallback onNext;
  final VoidCallback onSaveDraft;
  const _BottomNav({required this.currentStep, required this.onNext, required this.onSaveDraft});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 8, offset: const Offset(0, -2))],
      ),
      child: Row(
        children: [
          OutlinedButton(
            onPressed: onSaveDraft,
            child: const Text('Черновик'),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
              child: Text(currentStep < 3 ? 'Далее →' : 'Создать акт'),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Shared form widgets ──────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.primary),
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? hint;
  final int maxLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final Widget? suffix;

  const _FormField({
    required this.label,
    required this.controller,
    this.hint,
    this.maxLines = 1,
    this.maxLength,
    this.keyboardType,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      maxLength: maxLength,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        isDense: true,
        border: const OutlineInputBorder(),
        suffixIcon: suffix,
        counterText: maxLength != null ? null : '',
      ),
    );
  }
}

class _CountField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  const _CountField({required this.label, required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        isDense: true,
        border: const OutlineInputBorder(),
      ),
    );
  }
}

class _DatePickerField extends StatelessWidget {
  final String label;
  final DateTime? value;
  final ValueChanged<DateTime> onChanged;
  final bool allowNull;

  const _DatePickerField({
    required this.label,
    required this.value,
    required this.onChanged,
    this.allowNull = false,
  });

  @override
  Widget build(BuildContext context) {
    final displayDate = value != null
        ? '${value!.day.toString().padLeft(2, '0')}.${value!.month.toString().padLeft(2, '0')}.${value!.year}'
        : 'Не указана';

    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: value ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2030),
        );
        if (picked != null) onChanged(picked);
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          isDense: true,
          border: const OutlineInputBorder(),
          suffixIcon: const Icon(Icons.calendar_today, size: 16),
        ),
        child: Text(displayDate),
      ),
    );
  }
}

class _ProcedureTypeSelector extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;
  const _ProcedureTypeSelector({required this.value, required this.onChanged});

  static const _types = [
    ('vaccination', 'Вакцинация', Icons.vaccines),
    ('allergy_test', 'Аллерг. тест', Icons.biotech),
    ('deworming', 'Дегельминтиз.', Icons.medication),
    ('treatment', 'Лечение', Icons.medical_services),
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _types.map((t) {
        final selected = value == t.$1;
        return GestureDetector(
          onTap: () => onChanged(t.$1),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: selected ? AppColors.primary : Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: selected ? AppColors.primary : Colors.grey[300]!),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(t.$3, size: 16, color: selected ? Colors.white : AppColors.textSecondary),
                const SizedBox(width: 6),
                Text(
                  t.$2,
                  style: TextStyle(
                    color: selected ? Colors.white : AppColors.textPrimary,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _AnimalRegistryTable extends StatelessWidget {
  final List<Map<String, dynamic>> rows;
  final ValueChanged<int> onRemove;
  const _AnimalRegistryTable({required this.rows, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 12,
        headingRowHeight: 32,
        dataRowMinHeight: 28,
        dataRowMaxHeight: 36,
        columns: const [
          DataColumn(label: Text('№', style: TextStyle(fontSize: 11))),
          DataColumn(label: Text('Ид. номер', style: TextStyle(fontSize: 11))),
          DataColumn(label: Text('Пол', style: TextStyle(fontSize: 11))),
          DataColumn(label: Text('Возраст', style: TextStyle(fontSize: 11))),
          DataColumn(label: Text('Масть', style: TextStyle(fontSize: 11))),
          DataColumn(label: Text('', style: TextStyle(fontSize: 11))),
        ],
        rows: rows.asMap().entries.map((e) => DataRow(
          cells: [
            DataCell(Text('${e.key + 1}', style: const TextStyle(fontSize: 11))),
            DataCell(Text(e.value['identification_no'] ?? '—', style: const TextStyle(fontSize: 11))),
            DataCell(Text(e.value['sex'] == 'male' ? 'Сам.' : 'Сам.', style: const TextStyle(fontSize: 11))),
            DataCell(Text(e.value['age_group'] == 'adult' ? 'Взр.' : 'Мол.', style: const TextStyle(fontSize: 11))),
            DataCell(Text(e.value['color'] ?? '—', style: const TextStyle(fontSize: 11))),
            DataCell(IconButton(
              icon: const Icon(Icons.delete_outline, size: 16, color: AppColors.danger),
              onPressed: () => onRemove(e.key),
            )),
          ],
        )).toList(),
      ),
    );
  }
}

class _PreviewRow extends StatelessWidget {
  final String label;
  final String value;
  const _PreviewRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          SizedBox(
            width: 130,
            child: Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
          ),
          Expanded(
            child: Text(value.isEmpty ? '—' : value,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}

class _MaterialRow extends StatelessWidget {
  final String name;
  final String qty;
  const _MaterialRow(this.name, this.qty);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Expanded(child: Text(name, style: const TextStyle(fontSize: 12))),
          Text(qty, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
