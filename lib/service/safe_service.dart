import 'dart:async';

import 'package:scoped_model/scoped_model.dart';

import 'package:flutter_todo/models/safe/Safe.dart';

mixin CoreModel on Model {
  List<Safe> _safes = [];
  bool _isLoading = false;

}

mixin SafeModel on CoreModel {

  bool get isLoading {
    return _isLoading;
  }

  Future<bool> fetchSafes(
      ) async {
    _isLoading = true;
    notifyListeners();




    _isLoading = false;
    notifyListeners();

    return true;

  }
}
