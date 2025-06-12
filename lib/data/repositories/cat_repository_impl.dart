import 'package:meows_pedia/data/mappers/mappers.dart';
import 'package:meows_pedia/data/models/cat_model.dart';
import 'package:meows_pedia/domain/datasources/cat_remote_data_source.dart';
import 'package:meows_pedia/domain/entities/cat.dart';
import 'package:meows_pedia/domain/repositories/cat_repository.dart';

class CatRepositoryImpl implements CatRepository {
  final CatRemoteDataSource remoteDataSource;

  CatRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Cat>> getCats({int limit = 10, int page = 0}) async {
    try {
      final List<CatModel> catModels =
          await remoteDataSource.fetchCats(limit: limit, page: page);

      final List<Cat> cats =
          catModels.map((catModel) => catModel.toEntity()).toList();

      for (Cat cat in cats) {
        if (cat.image == null && cat.referenceImageId != null) {
          final imageUrl =
              await remoteDataSource.fetchCatImage(cat.referenceImageId!);
          if (imageUrl != null) {
            cat.setImage(CatImage(id: cat.referenceImageId!, url: imageUrl));
          }
        }
      }

      return cats;
    } catch (error) {
      throw Exception('Failed to load cats: $error');
    }
  }
}
