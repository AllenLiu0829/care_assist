import 'package:firebase_auth/firebase_auth.dart';

import 'package:care_assist/models/user.dart' as models;
import 'package:care_assist/repositories/user_repo.dart';

class AuthenticationService {
  final UserRepository _userRepository;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  AuthenticationService({UserRepository? userRepository})
      : _userRepository = userRepository ?? UserRepository();

  Future<String?> registration({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await _userRepository
          .createOrUpdateUser(models.User(email: email, name: name));
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return e.message;
      }
    }
  }

  Future<String?> login({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "User not found";
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return e.message;
      }
    }
  }
}
