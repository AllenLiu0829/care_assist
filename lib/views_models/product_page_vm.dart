import 'dart:async';
import 'package:care_assist/models/company_info.dart';
import 'package:flutter/material.dart';

import 'package:care_assist/models/product.dart';
import 'package:care_assist/repositories/product_repo.dart';

class ProductViewModel with ChangeNotifier {
  final ProductRepository _productRepository;
  StreamSubscription<List<Product>>? _productSubscription;

  final String companyId;
  List<CompanyInfo> _otherCompanies = [];
  List<CompanyInfo> get otherCompanies => _otherCompanies;
  List<Product> _products = [];
  List<Product> get products => _products;

  ProductViewModel(
      {required this.companyId, ProductRepository? productRepository})
      : _productRepository = productRepository ?? ProductRepository() {
    _productSubscription = _productRepository.streamProduct(companyId).listen(
      (infos) {
        _products = infos;
        notifyListeners();
      },
    );
  }

  @override
  void dispose() {
    _productSubscription?.cancel();
    super.dispose();
  }

  void updateViewModel(List<CompanyInfo> allCompanies) {
    _otherCompanies =
        allCompanies.where((company) => company.id != companyId).toList();
    notifyListeners();
  }

  Future<void> createProduct(
      String name, List<bool> tag, String url, int price, String info) async {
    Product newProduct = Product(name: name, info: info);
    return await _productRepository.createProduct(newProduct, companyId);
  }

  Future<void> updateProduct(Product oldProduct, Product newProduct) async {
    return await _productRepository.updateProduct(
        newProduct, oldProduct, companyId);
  }

  Future<void> deleteProduct(Product product) async {
    return await _productRepository.deleteProduct(product, companyId);
  }
}
