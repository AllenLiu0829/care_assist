import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:care_assist/models/survey_info.dart';

class SurveyInfoRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final timeout = const Duration(seconds: 10);

  Stream<List<SurveyInfo>> streamSurveyInfo() {
    return _db.collection('survey').snapshots().map((querySnapshot) {
      return querySnapshot.docs
          .map((docSnapshot) =>
              SurveyInfo.fromMap(docSnapshot.data(), docSnapshot.id))
          .toList();
    });
  }

  Future<void> createSurveyInfo(SurveyInfo newSurveyInfo) async {
    Map<String, dynamic> newSurveyInfoMap = newSurveyInfo.toMap();
    await _db
        .collection('survey')
        .doc(newSurveyInfo.id)
        .set(newSurveyInfoMap)
        .timeout(timeout);
  }

  Future<void> updateSurveyInfo(
      SurveyInfo oldSurveyInfo, SurveyInfo newSurveyInfo) async {
    Map<String, dynamic> newSurveyInfoMap = newSurveyInfo.toMap();
    final oldSurveyInfoRef = _db.collection('survey').doc(oldSurveyInfo.id);
    _db.runTransaction((transaction) async {
      final oldSurveyInfoSnapShot = await transaction.get(oldSurveyInfoRef);
      if (!oldSurveyInfoSnapShot.exists) {
        throw Exception("Old Survey Info not Found!");
      }
      _db.collection('survey').doc(oldSurveyInfo.id).set(newSurveyInfoMap);
    });
  }

  Future<void> deleteSurveyInfo(SurveyInfo surveyInfo) async {
    await _db.collection('survey').doc(surveyInfo.id).delete().timeout(timeout);
  }
}
