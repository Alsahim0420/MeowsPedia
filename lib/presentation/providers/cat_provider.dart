import 'package:flutter/material.dart';
import '../../domain/entities/cat.dart';
import '../../domain/repositories/cat_repository.dart';

enum SortOption { country, affection, energy, intelligence }

class CatProvider extends ChangeNotifier {
  final CatRepository repository;

  List<Cat> _cats = [];
  List<Cat> get cats => _cats;
  List<Cat> get filteredCats => _filteredCats;

  List<Cat> _filteredCats = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isAscending = true;
  bool get isAscending => _isAscending;

  SortOption _sortOption = SortOption.country;
  SortOption get sortOption => _sortOption;

  int _currentPage = 0;
  final int _limit = 10;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  bool get isLoadingMore => _isLoadingMore;
  bool get hasMore => _hasMore;

  final Map<String, String> _imageUrlCache = {};

  CatProvider({required this.repository});

  Future<void> fetchCats({bool reset = false}) async {
    if (reset) {
      _currentPage = 0;
      _cats = [];
      _filteredCats = [];
      _hasMore = true;
      _imageUrlCache.clear();
    }
    _isLoading = true;
    notifyListeners();

    final newCats = await repository.getCats(limit: _limit, page: _currentPage);
    for (var cat in newCats) {
      if (cat.image == null && cat.referenceImageId != null) {
        if (_imageUrlCache.containsKey(cat.referenceImageId)) {
          cat.setImage(CatImage(
              id: cat.referenceImageId!,
              url: _imageUrlCache[cat.referenceImageId!]!));
        } else {
          // La imagen se pedirá en el repo, pero si no está, la próxima vez la cacheamos aquí
          // (esto es redundante, pero asegura que nunca se repita la petición)
        }
      } else if (cat.image != null && cat.referenceImageId != null) {
        _imageUrlCache[cat.referenceImageId!] = cat.image!.url;
      }
    }
    if (newCats.length < _limit) {
      _hasMore = false;
    }
    _cats.addAll(newCats);
    _filteredCats = _cats;
    _applySorting();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchMoreCats() async {
    if (_isLoadingMore || !_hasMore) return;
    _isLoadingMore = true;
    _currentPage++;
    notifyListeners();

    final newCats = await repository.getCats(limit: _limit, page: _currentPage);
    for (var cat in newCats) {
      if (cat.image == null && cat.referenceImageId != null) {
        if (_imageUrlCache.containsKey(cat.referenceImageId)) {
          cat.setImage(CatImage(
              id: cat.referenceImageId!,
              url: _imageUrlCache[cat.referenceImageId!]!));
        }
      } else if (cat.image != null && cat.referenceImageId != null) {
        _imageUrlCache[cat.referenceImageId!] = cat.image!.url;
      }
    }
    if (newCats.length < _limit) {
      _hasMore = false;
    }
    _cats.addAll(newCats);
    _filteredCats = _cats;
    _applySorting();

    _isLoadingMore = false;
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
