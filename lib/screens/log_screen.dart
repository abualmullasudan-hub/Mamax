import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme.dart';
import '../providers/app_state.dart';

class LogScreen extends StatelessWidget {
  const LogScreen({super.key});

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
              Icon(Icons.list_alt, color: AppTheme.txtLight),
              SizedBox(width: 8),
              Text('سجل الحركات', style: TextStyle(color: AppTheme.txtLight, fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: state.transactions.length,
            itemBuilder: (context, index) {
              final tx = state.transactions[index];
              final isDep = tx.type == 'dep';
              final isWd = tx.type == 'wd';
              
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.cream,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.line, width: 2),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(color: AppTheme.sand, shape: BoxShape.circle),
                      child: Icon(
                        isDep ? Icons.arrow_downward : isWd ? Icons.arrow_upward : Icons.swap_horiz,
                        color: isDep ? AppTheme.green : isWd ? AppTheme.red : AppTheme.ink,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isDep 
                              ? 'من ${tx.sourceDest} إلى ${tx.toPersonName ?? ""}' 
                              : isWd 
                                ? 'من ${tx.fromPersonName ?? ""} إلى ${tx.sourceDest}'
                                : 'تحويل من ${tx.fromPersonName} إلى ${tx.toPersonName}',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            tx.date,
                            style: const TextStyle(fontSize: 10, color: AppTheme.dk2),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${isWd ? '-' : isDep ? '+' : ''}${tx.amount} ${state.currency}',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: isDep ? AppTheme.green : isWd ? AppTheme.red : AppTheme.ink,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
