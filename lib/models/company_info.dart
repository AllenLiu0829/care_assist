class CompanyInfo {
  String? id;
  final String name;
  final String info;

  CompanyInfo({
    required this.name,
    required this.info,
  });

  CompanyInfo._({
    required this.id,
    required this.name,
    required this.info,
  });

  factory CompanyInfo.fromMap(Map<String, dynamic> map, String id) {
    return CompanyInfo._(
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
