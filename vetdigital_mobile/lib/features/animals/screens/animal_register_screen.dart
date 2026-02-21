import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class AnimalRegisterScreen extends StatefulWidget {
  const AnimalRegisterScreen({super.key});

  @override
  State<AnimalRegisterScreen> createState() => _AnimalRegisterScreenState();
}

class _AnimalRegisterScreenState extends State<AnimalRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedSpecies;
  String? _selectedSex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Регистрация животного')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Identification
              Text('Идентификация', style: _sectionStyle),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Идентификационный номер *', prefixIcon: Icon(Icons.numbers)),
                validator: (v) => (v?.isEmpty ?? true) ? 'Обязательное поле' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Номер микрочипа (15 цифр)', prefixIcon: Icon(Icons.nfc), counterText: ''),
                maxLength: 15,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Номер RFID метки', prefixIcon: Icon(Icons.radio_button_checked)),
              ),
              const SizedBox(height: 20),

              // Species
              Text('Характеристики', style: _sectionStyle),
              DropdownButtonFormField<String>(
                value: _selectedSpecies,
                decoration: const InputDecoration(labelText: 'Вид животного *', prefixIcon: Icon(Icons.pets)),
                items: const [
                  DropdownMenuItem(value: 'cattle', child: Text('КРС (ірі қара мал)')),
                  DropdownMenuItem(value: 'sheep', child: Text('МРС - Овцы')),
                  DropdownMenuItem(value: 'goat', child: Text('МРС - Козы')),
                  DropdownMenuItem(value: 'horse', child: Text('Лошади (жылқы)')),
                  DropdownMenuItem(value: 'camel', child: Text('Верблюды (түйе)')),
                  DropdownMenuItem(value: 'deer', child: Text('Маралы')),
                  DropdownMenuItem(value: 'poultry', child: Text('Птицы')),
                  DropdownMenuItem(value: 'dog', child: Text('Собаки')),
                  DropdownMenuItem(value: 'cat', child: Text('Кошки')),
                ],
                onChanged: (v) => setState(() => _selectedSpecies = v),
                validator: (v) => v == null ? 'Выберите вид' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _selectedSex,
                decoration: const InputDecoration(labelText: 'Пол *'),
                items: const [
                  DropdownMenuItem(value: 'male', child: Text('Самец (erkek/еркек)')),
                  DropdownMenuItem(value: 'female', child: Text('Самка (urgashi/ұрғашы)')),
                ],
                onChanged: (v) => setState(() => _selectedSex = v),
                validator: (v) => v == null ? 'Выберите пол' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Масть (цвет)', prefixIcon: Icon(Icons.color_lens)),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Вес (кг)', prefixIcon: Icon(Icons.scale)),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),

              // Owner
              Text('Владелец', style: _sectionStyle),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'ИИН владельца *',
                  prefixIcon: Icon(Icons.person),
                  suffixIcon: Icon(Icons.search),
                ),
                maxLength: 12,
                keyboardType: TextInputType.number,
                validator: (v) => (v?.isEmpty ?? true) ? 'Обязательное поле' : null,
              ),
              const SizedBox(height: 24),

              ElevatedButton.icon(
                onPressed: _submit,
                icon: const Icon(Icons.save),
                label: const Text('Зарегистрировать'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle get _sectionStyle => const TextStyle(
    fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.primary,
  );

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // TODO: Phase 2 - Call API and handle offline queue
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Сохранение... (API Phase 2)')),
      );
    }
  }
}
