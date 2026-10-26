class Person {
  String id;
  String name;
  int iconIndex;
  int colorIndex;
  Map<String, double> wallets; // يحفظ أرصدة الصندوق والبنوك
  double alertThreshold;
  String phone;

  Person({
    required this.id,
    required this.name,
    required this.iconIndex,
    required this.colorIndex,
    required this.wallets,
    this.alertThreshold = 0,
    this.phone = '',
  });

  // دالة لحساب إجمالي رصيد الشخص في كل المحافظ
  double get totalBalance => wallets.values.fold(0.0, (sum, val) => sum + val);

  // للتحويل إلى JSON للحفظ
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'iconIndex': iconIndex,
    'colorIndex': colorIndex,
    'wallets': wallets,
    'alertThreshold': alertThreshold,
    'phone': phone,
  };

  // للقراءة من JSON
  factory Person.fromJson(Map<String, dynamic> json) => Person(
    id: json['id'],
    name: json['name'],
    iconIndex: json['iconIndex'] ?? 0,
    colorIndex: json['colorIndex'] ?? 0,
    wallets: Map<String, double>.from(json['wallets'] ?? {'cash': 0.0}),
    alertThreshold: (json['alertThreshold'] ?? 0).toDouble(),
    phone: json['phone'] ?? '',
  );
}
