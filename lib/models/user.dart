import 'package:care_assist/models/login_method.dart';

class User {
  String? id;
  final String email;
  final String name;

  late final List<LoginMethod> loginMethods;
  bool _isModerator = false;
  bool get isModerator => _isModerator;

  User({
    required this.email,
    required this.name,
    logInMethods,
  }) : loginMethods = logInMethods ?? [];

  User._({
    required this.id,
    required this.email,
    required this.name,
    loginMethods,
    isModerator = false,
  })  : loginMethods = loginMethods ?? [],
        _isModerator = isModerator;

  factory User.fromMap(Map<String, dynamic> map, String id) {
    return User._(
      id: id,
      email: map['email'],
      name: map['name'],
      loginMethods: (map['loginMethods'] as List<dynamic>)
          .map((loginMethod) => LoginMethod.values.byName(loginMethod))
          .toList(),
      isModerator: map['isModerator'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'logInMethods':
          loginMethods.map((loginMethod) => loginMethod.name).toList(),
      'isModerator': _isModerator,
    };
  }
}
