import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:care_assist/models/user.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final timeout = const Duration(seconds: 10);

  Stream<User?> streamUser(String userId) {
    return _db.collection('users').doc(userId).snapshots().map((snapshot) {
      return snapshot.data() == null
          ? null
          : User.fromMap(snapshot.data()!, snapshot.id);
    });
  }

  Future<void> createUser(User user) async {
    Map<String, dynamic> userMap = user.toMap();
    await _db.collection('users').doc(user.id).set(userMap).timeout(timeout);
  }

  Future<void> createOrUpdateUser(User user) async {
    Map<String, dynamic> userMap = user.toMap();
    await _db.collection('users').doc(user.id).set(userMap);
  }

  Future<User?> getUserByEmail(String email) async {
    try {
      QuerySnapshot querySnapshot =
          await _db.collection('users').where('email', isEqualTo: email).get();
      if (querySnapshot.docs.isEmpty) {
        return null;
      }
      return User.fromMap(
        querySnapshot.docs.first.data() as Map<String, dynamic>,
        querySnapshot.docs.first.id,
      );
    } catch (e) {
      print('Error getting user by email: $e');
      return null;
    }
  }
}
