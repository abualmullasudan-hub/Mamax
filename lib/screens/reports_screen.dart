import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../core/theme.dart';
import '../providers/app_state.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  // دالة توليد ملف PDF للتقرير المالي
  Future<void> _generateFinancialReport(BuildContext context, AppState state) async {
    final pdf = pw.Document();
    
    double inc = state.transactions.where((t) => t.type == 'dep').fold(0, (a, t) => a + t.amount);
    double exp = state.transactions.where((t) => t.type == 'wd').fold(0, (a, t) => a + t.amount);
    double total = state.people.fold(0, (a, p) => a + p.totalBalance);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        textDirection: pw.TextDirection.rtl,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(child: pw.Text('تطبيق MAMX', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold))),
              pw.SizedBox(height: 10),
              pw.Center(child: pw.Text('تقرير مالي شامل', style: pw.TextStyle(fontSize: 18))),
              pw.SizedBox(height: 20),
              pw.Text('إجمالي الدخل: $inc ${state.currency}'),
              pw.Text('إجمالي المصروف: $exp ${state.currency}'),
              pw.Text('صافي الرصيد الإجمالي: $total ${state.currency}', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Divider(),
              pw.Center(child: pw.Text('تم إنشاؤه آلياً بواسطة MAMX')),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppState>(context);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          color: AppTheme.dk2,
          child: const Row(
            children: [
              Icon(Icons.bar_chart, color: AppTheme.txtLight),
              SizedBox(width: 8),
              Text('التقارير', style: TextStyle(color: AppTheme.txtLight, fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                // بطاقة تقرير مالي
                GestureDetector(
                  onTap: () => _generateFinancialReport(context, state),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: AppTheme.cream,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppTheme.line, width: 2),
                    ),
                    child: const Row(
                      children: [
                        CircleAvatar(backgroundColor: AppTheme.green, child: Icon(Icons.assessment, color: Colors.white)),
                        SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('تقرير مالي شامل', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.ink)),
                            Text('ملخص الإيداعات، السحوبات، والأرصدة', style: TextStyle(fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                
                // يمكنك إضافة المزيد من البطاقات هنا بنفس التصميم (مثل تقرير الحركات أو الأرصدة)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
