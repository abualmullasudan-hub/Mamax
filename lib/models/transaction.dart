class Transaction {
  String id;
  String type; // 'dep' للإيداع، 'wd' للسحب، 'tr' للتحويل
  double amount;
  String date;
  String? fromPersonId;
  String? fromPersonName;
  String? fromWallet;
  String? toPersonId;
  String? toPersonName;
  String? toWallet;
  String sourceDest; // جهة الإيداع أو السحب
  String note;

  Transaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.date,
    this.fromPersonId,
    this.fromPersonName,
    this.fromWallet,
    this.toPersonId,
    this.toPersonName,
    this.toWallet,
    this.sourceDest = '',
    this.note = '',
  });

  Map<String, dynamic> toJson() => {
    'id': id, 'type': type, 'amount': amount, 'date': date,
    'fromPersonId': fromPersonId, 'fromPersonName': fromPersonName, 'fromWallet': fromWallet,
    'toPersonId': toPersonId, 'toPersonName': toPersonName, 'toWallet': toWallet,
    'sourceDest': sourceDest, 'note': note,
  };

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    id: json['id'], type: json['type'], amount: (json['amount'] ?? 0).toDouble(), date: json['date'],
    fromPersonId: json['fromPersonId'], fromPersonName: json['fromPersonName'], fromWallet: json['fromWallet'],
    toPersonId: json['toPersonId'], toPersonName: json['toPersonName'], toWallet: json['toWallet'],
    sourceDest: json['sourceDest'] ?? '', note: json['note'] ?? '',
  );
}
