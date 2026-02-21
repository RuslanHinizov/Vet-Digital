import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// Document preview and EDS signing screen.
/// Shows procedure act PDF preview and eGov Mobile QR signing flow.
class DocumentPreviewScreen extends StatefulWidget {
  final String documentId;
  final String documentType;

  const DocumentPreviewScreen({
    super.key,
    required this.documentId,
    required this.documentType,
  });

  @override
  State<DocumentPreviewScreen> createState() => _DocumentPreviewScreenState();
}

class _DocumentPreviewScreenState extends State<DocumentPreviewScreen> {
  bool _isSigned = false;
  bool _showingQr = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_docTitle()),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _shareDocument,
          ),
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: _printDocument,
          ),
        ],
      ),
      body: Column(
        children: [
          // Signature status banner
          if (_isSigned)
            Container(
              color: AppColors.success.withOpacity(0.1),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: const Row(
                children: [
                  Icon(Icons.verified, color: AppColors.success, size: 18),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Документ подписан ЭЦП. Юридически значимый.',
                      style: TextStyle(color: AppColors.success, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),

          // PDF preview area
          Expanded(
            child: _showingQr
                ? _EdsQrPanel(
                    documentId: widget.documentId,
                    onSigned: () => setState(() {
                      _isSigned = true;
                      _showingQr = false;
                    }),
                    onCancel: () => setState(() => _showingQr = false),
                  )
                : _DocumentView(documentType: widget.documentType),
          ),

          // Bottom action panel
          if (!_isSigned)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, -2))],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Для придания юридической силы подпишите документ ЭЦП',
                    style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => setState(() => _showingQr = false),
                          icon: const Icon(Icons.save_alt, size: 16),
                          label: const Text('Сохранить черновик'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => setState(() => _showingQr = true),
                          icon: const Icon(Icons.qr_code, size: 16),
                          label: const Text('Подписать ЭЦП'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.success,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  String _docTitle() {
    switch (widget.documentType) {
      case 'procedure_act': return 'Акт процедуры';
      case 'vaccination_certificate': return 'Справка о вакцинации';
      case 'owner_consent': return 'Согласие владельца';
      default: return 'Документ';
    }
  }

  void _shareDocument() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Поделиться... (Phase 5 - MinIO URL)')),
    );
  }

  void _printDocument() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Печать... (Phase 5 - PDF generator)')),
    );
  }
}

// ─── Document View (PDF placeholder) ─────────────────────────────────────────

class _DocumentView extends StatelessWidget {
  final String documentType;
  const _DocumentView({required this.documentType});

  @override
  Widget build(BuildContext context) {
    // TODO: Phase 5 - Render actual PDF from MinIO using pdf_render package
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Document header (A4 style)
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey[300]!),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
            ),
            child: Column(
              children: [
                // Ministry header
                const Text(
                  'МИНИСТЕРСТВО СЕЛЬСКОГО ХОЗЯЙСТВА\nРЕСПУБЛИКИ КАЗАХСТАН',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                const Divider(),
                Text(
                  documentType == 'procedure_act'
                      ? 'АКТ\nо проведении ветеринарного мероприятия'
                      : 'ДОКУМЕНТ',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                _DocRow('Номер акта:', 'АКТ-2025-001'),
                _DocRow('Дата:', '15 марта 2025 г.'),
                _DocRow('Место:', 'Алматинская обл., Карасайский р-н'),
                _DocRow('Специалист:', 'Сейтқали А.М.'),
                const Divider(),
                _DocRow('Вид мероприятия:', 'Вакцинация против ящура'),
                _DocRow('Вид животных:', 'Крупный рогатый скот (КРС)'),
                _DocRow('Охвачено:', '45 голов'),
                const Divider(),
                _DocRow('Вакцина:', 'ARRIAH FMD O/A/Asia-1'),
                _DocRow('Производитель:', 'ФГБУ «ВНИИЗЖ»'),
                _DocRow('Серия:', '2024-03'),
                _DocRow('Доза (взр.):', '2.0 мл'),
                _DocRow('Доза (мол.):', '1.0 мл'),
                _DocRow('Метод введения:', 'Подкожно'),
                const SizedBox(height: 24),
                // Signature area
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Ветеринарный специалист', style: TextStyle(fontSize: 11)),
                          const SizedBox(height: 20),
                          Container(height: 1, color: Colors.black),
                          const Text('(подпись)', style: TextStyle(fontSize: 9, color: AppColors.textSecondary)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Владелец животных', style: TextStyle(fontSize: 11)),
                          const SizedBox(height: 20),
                          Container(height: 1, color: Colors.black),
                          const Text('(подпись)', style: TextStyle(fontSize: 9, color: AppColors.textSecondary)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[400]!),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Column(
                    children: [
                      Text('МП', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                      SizedBox(height: 20),
                      Text('(место печати)', style: TextStyle(fontSize: 9, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DocRow extends StatelessWidget {
  final String label;
  final String value;
  const _DocRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}

// ─── EDS QR Signing Panel ─────────────────────────────────────────────────────

class _EdsQrPanel extends StatefulWidget {
  final String documentId;
  final VoidCallback onSigned;
  final VoidCallback onCancel;

  const _EdsQrPanel({
    required this.documentId,
    required this.onSigned,
    required this.onCancel,
  });

  @override
  State<_EdsQrPanel> createState() => _EdsQrPanelState();
}

class _EdsQrPanelState extends State<_EdsQrPanel> {
  bool _waitingForSignature = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.security, size: 48, color: AppColors.primary),
          const SizedBox(height: 16),
          const Text(
            'Подписание документа ЭЦП',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Откройте приложение eGov Mobile и отсканируйте QR-код для подписи документа',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 24),

          // QR Code placeholder
          // TODO: Phase 5 - Render actual QR from backend /api/v1/procedures/{id}/sign
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.qr_code_2, size: 120, color: AppColors.primary),
                const SizedBox(height: 8),
                Text(
                  'ID: ${widget.documentId}',
                  style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Step instructions
          const _EdsStep(step: 1, text: 'Откройте eGov Mobile на вашем телефоне'),
          const _EdsStep(step: 2, text: 'Выберите «Подписать QR»'),
          const _EdsStep(step: 3, text: 'Наведите камеру на QR-код выше'),
          const _EdsStep(step: 4, text: 'Подтвердите подпись PIN-кодом'),
          const SizedBox(height: 24),

          if (_waitingForSignature) ...[
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)),
                SizedBox(width: 8),
                Text('Ожидание подписи...', style: TextStyle(color: AppColors.textSecondary)),
              ],
            ),
            const SizedBox(height: 16),
          ],

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: widget.onCancel,
                  child: const Text('Отмена'),
                ),
              ),
              const SizedBox(width: 12),
              // Demo: simulate successful signing
              Expanded(
                child: ElevatedButton(
                  onPressed: widget.onSigned,
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.success),
                  child: const Text('Тест: подписать'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EdsStep extends StatelessWidget {
  final int step;
  final String text;
  const _EdsStep({required this.step, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text('$step',
                  style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }
}
