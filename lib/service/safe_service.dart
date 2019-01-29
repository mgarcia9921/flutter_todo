import 'dart:async';

import 'package:scoped_model/scoped_model.dart';

import 'package:flutter_todo/models/safe/Safe.dart';

mixin SafeCoreModel on Model {
  List<Safe> _safes = [];
  bool _isLoading = false;
}

mixin SafeModel on SafeCoreModel {
  Safe _safe;

  bool get isLoading {
    return _isLoading;
  }

  Safe get currentSafe {
    return _safe;
  }

  Future<bool> fetchSafes() async {
    _isLoading = true;
    notifyListeners();

    // TODO Add service

    _isLoading = false;
    notifyListeners();

    return true;
  }

  Future<bool> updateSafe() async {
    _isLoading = true;
    notifyListeners();

    Safe safe = Safe(
      id: '1',
      name: '',
      type: '',
    );
    int safeIndex = _safes.indexWhere((t) => t.id == '1');
    _safes[safeIndex] = safe;

    _isLoading = false;
    notifyListeners();

    return true;
  }

  Future<bool> createSafe() async {
    _isLoading = true;
    notifyListeners();

    Safe todo = Safe(
      id: "1",
      name: '',
      type: '',
    );
    _safes.add(todo);

    _isLoading = false;
    notifyListeners();

    return true;
  }
}
