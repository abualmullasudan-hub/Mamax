import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme.dart';
import '../core/constants.dart';
import '../providers/app_state.dart';
import 'add_person_modal.dart';

class AccountsModal extends StatelessWidget {
  const AccountsModal({super.key});

  void _openAddPerson(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const AddPersonModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppState>(context);

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        color: AppTheme.bg,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        border: Border(top: BorderSide(color: AppTheme.gold, width: 3)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.close, color: AppTheme.red),
                onPressed: () => Navigator.pop(context),
              ),
              const Text('الحسابات المسجلة', style: TextStyle(color: AppTheme.txtLight, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(width: 40),
            ],
          ),
          const SizedBox(height: 10),
          
          state.people.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('لا توجد حسابات ظاهرة', style: TextStyle(color: AppTheme.txtLight)),
                )
              : Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: state.people.map((p) {
                    return Container(
                      width: (MediaQuery.of(context).size.width - 40) / 2,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppTheme.cream,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppTheme.line, width: 2),
                      ),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppConstants.accountColors[p.colorIndex],
                            child: Icon(AppConstants.accountIcons[p.iconIndex], color: Colors.white),
                          ),
                          const SizedBox(height: 5),
                          Text(p.name, style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.ink)),
                          Text('${p.totalBalance} ${state.currency}', style: const TextStyle(color: AppTheme.green, fontSize: 12)),
                        ],
                      ),
                    );
                  }).toList(),
                ),
          
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _openAddPerson(context),
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text('إضافة حساب جديد', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.dk1,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
