import 'dart:async';
import 'package:flutter/material.dart';

import 'package:care_assist/models/survey_info.dart';
import 'package:care_assist/repositories/survey_repo.dart';

class SurveyInfoViewModel with ChangeNotifier {
  final SurveyInfoRepository _surveyInfoRepository;
  StreamSubscription<List<SurveyInfo>>? _surveyInfoSubscription;

  List<SurveyInfo> _surveyInfos = [];
  List<SurveyInfo> get surveyInfos => _surveyInfos;

  SurveyInfoViewModel({SurveyInfoRepository? surveyInfoRepository})
      : _surveyInfoRepository = surveyInfoRepository ?? SurveyInfoRepository() {
    _surveyInfoSubscription = _surveyInfoRepository.streamSurveyInfo().listen(
      (infos) {
        _surveyInfos = infos;
        notifyListeners();
      },
    );
  }

  @override
  void dispose() {
    _surveyInfoSubscription?.cancel();
    super.dispose();
  }

  void updateViewModel() {
    notifyListeners();
  }

  Future<void> createSurveyInfo(String question) async {
    SurveyInfo newSurveyInfo = SurveyInfo(question: question);
    return await _surveyInfoRepository.createSurveyInfo(newSurveyInfo);
  }

  Future<void> updateSurveyInfo(
      SurveyInfo oldSurveyInfo, SurveyInfo newSurveyInfo) async {
    return await _surveyInfoRepository.updateSurveyInfo(
        oldSurveyInfo, newSurveyInfo);
  }

  Future<void> deleteSurveyInfo(SurveyInfo surveyInfo) async {
    return await _surveyInfoRepository.deleteSurveyInfo(surveyInfo);
  }
}
