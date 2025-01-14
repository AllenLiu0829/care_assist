import 'dart:async';
import 'package:flutter/material.dart';

import 'package:care_assist/models/company_info.dart';
import 'package:care_assist/repositories/company_info_repo.dart';

class CompanyInfoViewModel with ChangeNotifier {
  final CompanyInfoRepository _companyInfoRepository;
  StreamSubscription<List<CompanyInfo>>? _companyInfoSubscription;

  List<CompanyInfo> _companyInfos = [];
  List<CompanyInfo> get companyInfos => _companyInfos;

  CompanyInfoViewModel({CompanyInfoRepository? companyInfoRepository})
      : _companyInfoRepository =
            companyInfoRepository ?? CompanyInfoRepository() {
    _companyInfoSubscription =
        _companyInfoRepository.streamCompanyInfo().listen(
      (infos) {
        _companyInfos = infos;
        notifyListeners();
      },
    );
  }

  @override
  void dispose() {
    _companyInfoSubscription?.cancel();
    super.dispose();
  }

  void updateViewModel() {
    notifyListeners();
  }

  Future<void> createCompanyInfo(String name, String info) async {
    CompanyInfo newCompanyInfo = CompanyInfo(name: name, info: info);
    return await _companyInfoRepository.createCompanyInfo(newCompanyInfo);
  }

  Future<void> updateCompanyInfo(
      CompanyInfo oldCompanyInfo, CompanyInfo newCompanyInfo) async {
    return await _companyInfoRepository.updateCompanyInfo(
        oldCompanyInfo, newCompanyInfo);
  }

  Future<void> deleteCompanyInfo(CompanyInfo companyInfo) async {
    return await _companyInfoRepository.deleteCompanyInfo(companyInfo);
  }
}
