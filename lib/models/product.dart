class Product {
  String? id;
  final String name;
  final String info;

  Product({
    required this.name,
    required this.info,
  });

  Product._({
    required this.id,
    required this.name,
    required this.info,
  });

  factory Product.fromMap(Map<String, dynamic> map, String id) {
    return Product._(
      id: id,
      name: map['name'],
      info: map['info'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'info': info,
    };
  }
}
