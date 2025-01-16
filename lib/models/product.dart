class Product {
  String? id;
  final String name;
  final String info;

  Product({
    required this.name,
    required this.info,
  });

  Product._({
    required this.name,
    required this.info,
  });

  factory Product.fromMap(Map<String, dynamic> map, String id) {
    return Product._(
      name: map['name'],
      info: map['info'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'info': info,
    };
  }
}
