import 'package:meows_pedia/domain/entities/cat.dart';
import 'package:meows_pedia/domain/repositories/cat_repository.dart';

class MockCatRepository implements CatRepository {
  @override
  Future<List<Cat>> getCats({int limit = 10, int page = 0}) async {
    // Retornar una lista de gatos de prueba
    return [
      Cat(
        id: '1',
        name: 'Siamese',
        weight: Weight(imperial: '10', metric: '4.5'),
        origin: 'Thailand',
        affectionLevel: 5,
        energyLevel: 4,
        intelligence: 5,
        referenceImageId: 'img1',
        image: CatImage(
            id: 'img1', url: 'https://cdn2.thecatapi.com/images/BQMSld0A0.jpg'),
      ),
      Cat(
        id: '2',
        name: 'Persian',
        weight: Weight(imperial: '12', metric: '5.5'),
        origin: 'Iran',
        affectionLevel: 4,
        energyLevel: 3,
        intelligence: 4,
        referenceImageId: 'img2',
        image: CatImage(
            id: 'img2', url: 'https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg'),
      ),
    ];
  }
}
