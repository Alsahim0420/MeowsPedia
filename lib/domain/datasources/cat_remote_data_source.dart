import 'package:meows_pedia/data/models/cat_model.dart';

abstract class CatRemoteDataSource {
  Future<List<CatModel>> fetchCats({int limit = 10, int page = 0});

  Future<String?> fetchCatImage(String referenceImageId);
}
