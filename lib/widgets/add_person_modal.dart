import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme.dart';
import '../core/constants.dart';
import '../providers/app_state.dart';
import '../models/person.dart';

class AddPersonModal extends StatefulWidget {
  const AddPersonModal({super.key});

  @override
  State<AddPersonModal> createState() => _AddPersonModalState();
}

class _AddPersonModalState extends State<AddPersonModal> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _balanceController = TextEditingController();
  int _selectedIcon = 0;

  void _save() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('أدخل اسم الحساب')));
      return;
    }

    final state = Provider.of<AppState>(context, listen: false);
    final newPerson = Person(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      iconIndex: _selectedIcon,
      colorIndex: state.people.length % AppConstants.accountColors.length,
      wallets: {'cash': double.tryParse(_balanceController.text) ?? 0.0},
      phone: _phoneController.text.trim(),
    );

    state.addPerson(newPerson);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: AppTheme.bg,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          border: Border(top: BorderSide(color: AppTheme.gold, width: 3)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('حساب جديد', style: TextStyle(color: AppTheme.txtLight, fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            
            // اختيار الأيقونة
            Wrap(
              spacing: 10,
              children: List.generate(AppConstants.accountIcons.length, (index) {
                final isSelected = _selectedIcon == index;
                return GestureDetector(
                  onTap: () => setState(() => _selectedIcon = index),
                  child: CircleAvatar(
                    backgroundColor: isSelected ? AppTheme.sand : AppTheme.cream,
                    child: Icon(AppConstants.accountIcons[index], color: isSelected ? AppTheme.ink : Colors.grey),
                  ),
                );
              }),
            ),
            const SizedBox(height: 15),

            // اسم الحساب
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'اسم الحساب',
                filled: true, fillColor: AppTheme.cream,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 10),

            // رقم الهاتف
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'رقم الهاتف (اختياري)',
                filled: true, fillColor: AppTheme.cream,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 10),

            // الرصيد الافتتاحي
            TextField(
              controller: _balanceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'رصيد افتتاحي في الصندوق',
                filled: true, fillColor: AppTheme.sand,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('حفظ الحساب', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
