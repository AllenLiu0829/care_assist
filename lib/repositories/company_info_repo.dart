import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:care_assist/models/company_info.dart';

class CompanyInfoRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final timeout = const Duration(seconds: 10);
  final collectionPath = 'company-info';

  Stream<List<CompanyInfo>> streamCompanyInfo() {
    return _db.collection(collectionPath).snapshots().map((querySnapshot) {
      return querySnapshot.docs
          .map((docSnapshot) =>
              CompanyInfo.fromMap(docSnapshot.data(), docSnapshot.id))
          .toList();
    });
  }

  Future<void> createCompanyInfo(CompanyInfo newCompanyInfo) async {
    Map<String, dynamic> newCompanyInfoMap = newCompanyInfo.toMap();
    await _db
        .collection(collectionPath)
        .doc(newCompanyInfo.id)
        .set(newCompanyInfoMap)
        .timeout(timeout);
  }

  Future<void> updateCompanyInfo(
      CompanyInfo oldCompanyInfo, CompanyInfo newCompanyInfo) async {
    Map<String, dynamic> newCompanyInfoMap = newCompanyInfo.toMap();
    final oldCompanyInfoRef =
        _db.collection(collectionPath).doc(oldCompanyInfo.id);
    _db.runTransaction((transaction) async {
      final oldCompanyInfoSnapShot = await transaction.get(oldCompanyInfoRef);
      if (!oldCompanyInfoSnapShot.exists) {
        throw Exception("Old Company Info not Found!");
      }
      _db
          .collection(collectionPath)
          .doc(oldCompanyInfo.id)
          .set(newCompanyInfoMap);
    });
  }

  Future<void> deleteCompanyInfo(CompanyInfo companyInfo) async {
    await _db
        .collection(collectionPath)
        .doc(companyInfo.id)
        .delete()
        .timeout(timeout);
  }
}
