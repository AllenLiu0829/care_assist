import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:care_assist/models/product.dart';

class ProductRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final timeout = const Duration(seconds: 10);

  Stream<List<Product>> streamProduct(String companyId) {
    return _db
        .collection('company-info')
        .doc(companyId)
        .collection('products')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((docSnapshot) =>
              Product.fromMap(docSnapshot.data(), docSnapshot.id))
          .toList();
    });
  }

  Future<void> createProduct(Product newProduct, String companyId) async {
    Map<String, dynamic> newProductMap = newProduct.toMap();
    await _db
        .collection('company-info')
        .doc(companyId)
        .collection('products')
        .add(newProductMap)
        .timeout(timeout);
  }

  Future<void> updateProduct(
      Product oldProduct, Product newProduct, String companyId) async {
    Map<String, dynamic> newProductMap = newProduct.toMap();
    final oldProductRef = _db
        .collection('company-info')
        .doc(companyId)
        .collection('products')
        .doc(oldProduct.id);
    _db.runTransaction((transaction) async {
      final oldProductSnapShot = await transaction.get(oldProductRef);
      if (!oldProductSnapShot.exists) {
        throw Exception("Old Products not Found!");
      }
      _db.collection('company-info').doc(oldProduct.id).set(newProductMap);
    });
  }

  Future<void> deleteProduct(Product oldProduct, String companyId) async {
    await _db
        .collection('company-info')
        .doc(companyId)
        .collection('products')
        .doc(oldProduct.id)
        .delete()
        .timeout(timeout);
  }
}
