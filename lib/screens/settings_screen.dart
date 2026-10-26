import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme.dart';
import '../providers/app_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
              Icon(Icons.settings, color: AppTheme.txtLight),
              SizedBox(width: 8),
              Text('الإعدادات', style: TextStyle(color: AppTheme.txtLight, fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              // قسم العملة
              _buildSection(
                title: 'العملة',
                icon: Icons.attach_money,
                child: TextField(
                  controller: TextEditingController(text: state.currency),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    filled: true,
                    fillColor: AppTheme.cream,
                  ),
                  onSubmitted: (val) {
                    state.currency = val.trim().isEmpty ? 'ج.س' : val.trim();
                    state.save();
                  },
                ),
              ),
              
              // قسم الثيمات (مبسط)
              _buildSection(
                title: 'مظهر التطبيق',
                icon: Icons.palette,
                child: Wrap(
                  spacing: 10,
                  children: [
                    _themeButton(context, 'البني الكلاسيكي', AppTheme.bg, AppTheme.dk1),
                    _themeButton(context, 'الأخضر', const Color(0xFF2E7D32), const Color(0xFF4CAF50)),
                    _themeButton(context, 'الأزرق', const Color(0xFF1A78C2), const Color(0xFF2B8CE6)),
                    _themeButton(context, 'الداكن', const Color(0xFF121212), const Color(0xFF3A3A3A)),
                  ],
                ),
              ),

              // قسم معلومات التطبيق
              _buildSection(
                title: 'عن المطور',
                icon: Icons.info,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('تطبيق MAMX - إدارة الحسابات', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text('المطور: Abu Almull', style: TextStyle(color: Colors.grey)),
                    Text('للدعم: 0922008009', style: TextStyle(color: Colors.grey, direction: TextDirection.ltr)),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSection({required String title, required IconData icon, required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: AppTheme.cream,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.line, width: 2),
      ),
      child: ExpansionTile(
        leading: CircleAvatar(backgroundColor: AppTheme.dk2, child: Icon(icon, color: AppTheme.txtLight)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.ink)),
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _themeButton(BuildContext context, String name, Color bg, Color primary) {
    return GestureDetector(
      onTap: () {
        // هنا يتم تطبيق الثيم (يتطلب ربطاً مع ThemeProvider)
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('سيتم تفعيل تغيير الثيم في التحديث القادم')));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: primary, width: 2),
        ),
        child: Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
