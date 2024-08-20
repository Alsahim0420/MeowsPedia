import 'package:flutter/material.dart';
import '../../domain/entities/cat.dart';
import '../../domain/repositories/cat_repository.dart';

enum SortOption { country, affection, energy, intelligence }

class CatProvider extends ChangeNotifier {
  final CatRepository repository;

  List<Cat> _cats = [];
  List<Cat> get cats => _filteredCats;

  List<Cat> _filteredCats = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isAscending = true;
  bool get isAscending => _isAscending;

  SortOption _sortOption = SortOption.country;
  SortOption get sortOption => _sortOption;

  CatProvider({required this.repository});

  Future<void> fetchCats() async {
    _isLoading = true;
    notifyListeners();

    _cats = await repository.getCats();
    _filteredCats = _cats;
    _applySorting();

    _isLoading = false;
    notifyListeners();
  }

  void searchCats(String query) {
    if (query.isEmpty) {
      _filteredCats = _cats;
    } else {
      _filteredCats = _cats
          .where((cat) => cat.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    _applySorting();
    notifyListeners();
  }

  void updateSortOption(SortOption option) {
    _sortOption = option;
    _applySorting();
    notifyListeners();
  }

  void toggleSortOrder() {
    _isAscending = !_isAscending;
    _applySorting();
    notifyListeners();
  }

  void _applySorting() {
    _filteredCats.sort((a, b) {
      int comparison = 0;

      switch (_sortOption) {
        case SortOption.country:
          comparison = a.origin?.compareTo(b.origin ?? '') ?? 0;
          break;
        case SortOption.affection:
          comparison = (a.affectionLevel ?? 0).compareTo(b.affectionLevel ?? 0);
          break;
        case SortOption.energy:
          comparison = (a.energyLevel ?? 0).compareTo(b.energyLevel ?? 0);
          break;
        case SortOption.intelligence:
          comparison = (a.intelligence ?? 0).compareTo(b.intelligence ?? 0);
          break;
      }

      return _isAscending ? comparison : -comparison;
    });
  }
}
