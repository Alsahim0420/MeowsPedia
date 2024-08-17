import 'package:meows_pedia/data/mappers/mappers.dart';
import 'package:meows_pedia/data/models/cat_model.dart';
import 'package:meows_pedia/domain/datasources/cat_remote_data_source.dart';
import 'package:meows_pedia/domain/entities/cat.dart';
import 'package:meows_pedia/domain/repositories/cat_repository.dart';

class CatRepositoryImpl implements CatRepository {
  final CatRemoteDataSource remoteDataSource;

  CatRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Cat>> getCats() async {
    try {
      // Obtener los datos de los gatos
      final List<CatModel> catModels = await remoteDataSource.fetchCats();

      // Convertir los modelos en entidades
      final List<Cat> cats =
          catModels.map((catModel) => catModel.toEntity()).toList();

      // Obtener y asignar la imagen para cada gato
      for (Cat cat in cats) {
        if (cat.referenceImageId != null) {
          final imageUrl =
              await remoteDataSource.fetchCatImage(cat.referenceImageId!);
          cat.setImage(
              CatImage(id: cat.referenceImageId!, url: imageUrl ?? ""));
        }
      }

      return cats;
    } catch (error) {
      throw Exception('Failed to load cats: $error');
    }
  }
}
