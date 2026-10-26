class Bank {
  String id;
  String name;

  Bank({required this.id, required this.name});

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
    id: json['id'],
    name: json['name'],
  );
}
