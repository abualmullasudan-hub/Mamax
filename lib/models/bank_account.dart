class BankAccount {
  String id;
  String bankId;
  String accountName;
  String accountNumber;
  String phone;

  BankAccount({
    required this.id,
    required this.bankId,
    required this.accountName,
    required this.accountNumber,
    this.phone = '',
  });

  Map<String, dynamic> toJson() => {
    'id': id, 'bankId': bankId, 'accountName': accountName, 
    'accountNumber': accountNumber, 'phone': phone
  };

  factory BankAccount.fromJson(Map<String, dynamic> json) => BankAccount(
    id: json['id'], bankId: json['bankId'], accountName: json['accountName'],
    accountNumber: json['accountNumber'], phone: json['phone'] ?? '',
  );
}
