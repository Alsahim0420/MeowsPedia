// lib/presentation/providers/cat_provider.dart

import 'package:flutter/material.dart';
import '../../domain/entities/cat.dart';
import '../../domain/repositories/cat_repository.dart';

class CatProvider extends ChangeNotifier {
  final CatRepository repository;

  List<Cat> _cats = [];
  List<Cat> get cats => _cats;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  CatProvider({required this.repository});

  Future<void> fetchCats() async {
    _isLoading = true;
    notifyListeners();

    _cats = await repository.getCats();

    _isLoading = false;
    notifyListeners();
  }

  void searchCats(String query) {
    if (query.isEmpty) {
      fetchCats();
    } else {
      _cats = _cats
          .where((cat) => cat.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      notifyListeners();
    }
  }
}
