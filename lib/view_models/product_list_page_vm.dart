import 'dart:async';
import 'package:flutter/material.dart';

import 'package:care_assist/models/product.dart';
import 'package:care_assist/repositories/product_list_repo.dart';

class ProductListViewModel with ChangeNotifier {
  final ProductListRepository _productListRepository;
  StreamSubscription<List<Product>>? _productListSubscription;

  List<Product> _productList = [];
  List<Product> get productList => _productList;

  ProductListViewModel({ProductListRepository? productListRepository})
      : _productListRepository =
            productListRepository ?? ProductListRepository() {
    _productListSubscription =
        _productListRepository.streamAllProducts().listen(
      (infos) {
        _productList = infos;
        notifyListeners();
      },
    );
  }

  @override
  void dispose() {
    _productListSubscription?.cancel();
    super.dispose();
  }
}
