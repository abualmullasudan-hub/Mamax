import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/person.dart';
import '../models/transaction.dart';
import '../models/bank.dart';
import '../models/bank_account.dart';

class AppState extends ChangeNotifier {
  static const String _storageKey = 'MAMX_v1';

  String currency = 'ج.س';
  List<Person> people = [];
  List<Transaction> transactions = [];
  List<Bank> banks = [];
  List<BankAccount> bankAccounts = [];
  List<String> hiddenStages = [];
  bool autoBackup = false;

  // تحميل البيانات عند فتح التطبيق
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString(_storageKey);
    
    if (data != null) {
      try {
        final Map<String, dynamic> json = jsonDecode(data);
        currency = json['currency'] ?? 'ج.س';
        hiddenStages = List<String>.from(json['hiddenStages'] ?? []);
        autoBackup = json['autoBackup'] ?? false;
        
        people = (json['people'] as List? ?? []).map((e) => Person.fromJson(e)).toList();
        transactions = (json['transactions'] as List? ?? []).map((e) => Transaction.fromJson(e)).toList();
        banks = (json['banks'] as List? ?? []).map((e) => Bank.fromJson(e)).toList();
        bankAccounts = (json['bankAccounts'] as List? ?? []).map((e) => BankAccount.fromJson(e)).toList();
      } catch (e) {
        debugPrint('خطأ في تحميل البيانات: $e');
      }
    } else {
      // بيانات افتراضية إذا كان التطبيق يفتح لأول مرة
      banks = [
        Bank(id: 'b1', name: 'بنك الخرطوم'),
        Bank(id: 'b2', name: 'بنك فيصل')
      ];
      save();
    }
    notifyListeners();
  }

  // حفظ البيانات في الهاتف
  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    final Map<String, dynamic> data = {
      'currency': currency,
      'hiddenStages': hiddenStages,
      'autoBackup': autoBackup,
      'people': people.map((p) => p.toJson()).toList(),
      'transactions': transactions.map((t) => t.toJson()).toList(),
      'banks': banks.map((b) => b.toJson()).toList(),
      'bankAccounts': bankAccounts.map((ba) => ba.toJson()).toList(),
    };
    await prefs.setString(_storageKey, jsonEncode(data));
    notifyListeners();
  }

  // دوال مساعدة لجلب البيانات
  Person? getPersonById(String id) {
    try {
      return people.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  String getWalletName(String walletId) {
    if (walletId == 'cash') return 'الصندوق';
    try {
      return banks.firstWhere((b) => b.id == walletId).name;
    } catch (e) {
      return 'بنك محذوف';
    }
  }

  // إضافة حساب جديد
  void addPerson(Person person) {
    people.add(person);
    save();
  }

  // إضافة حركة مالية (مع تحديث الأرصدة)
  void addTransaction(Transaction tx, bool applyToBalance) {
    if (applyToBalance) {
      if (tx.fromPersonId != null) {
        final fromP = getPersonById(tx.fromPersonId!);
        if (fromP != null) {
          fromP.wallets[tx.fromWallet!] = (fromP.wallets[tx.fromWallet!] ?? 0) - tx.amount;
        }
      }
      if (tx.toPersonId != null) {
        final toP = getPersonById(tx.toPersonId!);
        if (toP != null) {
          toP.wallets[tx.toWallet!] = (toP.wallets[tx.toWallet!] ?? 0) + tx.amount;
        }
      }
    }
    transactions.insert(0, tx); // إضافة الحركة في أعلى القائمة
    save();
  }
}
