import 'package:meows_pedia/data/models/cat_model.dart';

abstract class CatRemoteDataSource {
  Future<List<CatModel>> fetchCats();

  Future<String?> fetchCatImage(String referenceImageId);
}
