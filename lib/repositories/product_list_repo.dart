import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:care_assist/models/product.dart';

class ProductListRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Product>> streamAllProducts() {
    return _db.collectionGroup('products').snapshots().map((querySnapshot) {
      return querySnapshot.docs
          .map((docSnapshot) =>
              Product.fromMap(docSnapshot.data(), docSnapshot.id))
          .toList();
    });
  }
}
