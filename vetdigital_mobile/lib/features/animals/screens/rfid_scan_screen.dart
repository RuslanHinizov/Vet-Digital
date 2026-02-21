import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';

/// RFID scanning screen.
/// Connects to a Bluetooth Low Energy RFID reader (e.g., ISENVO AR190E)
/// to read 134.2 kHz FDX-B microchips (ISO 11784/11785).
///
/// Note: Smartphone NFC cannot read 134.2 kHz animal microchips.
/// An external Bluetooth RFID reader is required.
class RFIDScanScreen extends ConsumerStatefulWidget {
  const RFIDScanScreen({super.key});

  @override
  ConsumerState<RFIDScanScreen> createState() => _RFIDScanScreenState();
}

class _RFIDScanScreenState extends ConsumerState<RFIDScanScreen> {
  bool _isScanning = false;
  String? _scannedNumber;
  String _status = 'Подключите Bluetooth RFID сканер';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Сканирование RFID')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Scan animation area
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Scan icon
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        color: _isScanning
                            ? AppColors.primary.withOpacity(0.1)
                            : AppColors.border,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _isScanning ? AppColors.primary : AppColors.divider,
                          width: 3,
                        ),
                      ),
                      child: Icon(
                        Icons.nfc,
                        size: 80,
                        color: _isScanning ? AppColors.primary : AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      _status,
                      style: const TextStyle(fontSize: 16, color: AppColors.textSecondary),
                      textAlign: TextAlign.center,
                    ),

                    // Scanned number display
                    if (_scannedNumber != null) ...[
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.success.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.success),
                        ),
                        child: Column(
                          children: [
                            const Icon(Icons.check_circle, color: AppColors.success, size: 32),
                            const SizedBox(height: 8),
                            const Text('Считан номер:', style: TextStyle(color: AppColors.textSecondary)),
                            Text(
                              _scannedNumber!,
                              style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            // Instructions
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Инструкция',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text('1. Включите Bluetooth RFID сканер'),
                    Text('2. Нажмите "Подключить сканер"'),
                    Text('3. Поднесите сканер к микрочипу животного'),
                    Text('4. Животное будет найдено автоматически'),
                    SizedBox(height: 8),
                    Text(
                      'Совместимые сканеры: ISENVO AR190E, Allflex RS420, '
                      'и другие BLE 134.2 кГц FDX-B ридеры',
                      style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Connect button
            ElevatedButton.icon(
              onPressed: _toggleScan,
              icon: Icon(_isScanning ? Icons.bluetooth_disabled : Icons.bluetooth_searching),
              label: Text(_isScanning ? 'Остановить' : 'Подключить сканер'),
              style: ElevatedButton.styleFrom(
                backgroundColor: _isScanning ? AppColors.danger : AppColors.primary,
              ),
            ),
            const SizedBox(height: 12),

            // Manual input fallback
            OutlinedButton.icon(
              onPressed: _manualInput,
              icon: const Icon(Icons.keyboard),
              label: const Text('Ввести номер вручную'),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleScan() {
    setState(() {
      _isScanning = !_isScanning;
      _status = _isScanning
          ? 'Поиск Bluetooth сканера...'
          : 'Подключите Bluetooth RFID сканер';
    });
    // TODO: Phase 2 - flutter_blue_plus BLE connection
    if (_isScanning) {
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _status = 'BLE RFID интеграция будет в Phase 2.\nДля теста используйте ручной ввод.';
            _isScanning = false;
          });
        }
      });
    }
  }

  void _manualInput() {
    showDialog(
      context: context,
      builder: (ctx) {
        final ctrl = TextEditingController();
        return AlertDialog(
          title: const Text('Введите номер RFID/Чипа'),
          content: TextField(
            controller: ctrl,
            decoration: const InputDecoration(
              hintText: '15-значный номер',
              helperText: 'Номер микрочипа или RFID метки',
            ),
            maxLength: 50,
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Отмена')),
            ElevatedButton(
              onPressed: () {
                if (ctrl.text.isNotEmpty) {
                  Navigator.pop(ctx);
                  _processScannedNumber(ctrl.text.trim());
                }
              },
              child: const Text('Найти'),
            ),
          ],
        );
      },
    );
  }

  void _processScannedNumber(String number) {
    setState(() {
      _scannedNumber = number;
      _status = 'Поиск животного в базе данных...';
    });
    // TODO: Phase 2 - Call /api/v1/animals/rfid-lookup
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() => _status = 'API поиск будет в Phase 2');
      }
    });
  }
}
