import 'package:flutter_test/flutter_test.dart';
import 'package:meows_pedia/presentation/providers/cat_provider.dart';
import 'package:meows_pedia/domain/entities/cat.dart';
import 'package:meows_pedia/domain/repositories/cat_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'cat_provider_test.mocks.dart';

@GenerateMocks([CatRepository])
void main() {
  late MockCatRepository mockRepo;
  late CatProvider provider;
  final cats = [
    Cat(
        id: '1',
        name: 'Gato',
        weight: Weight(imperial: '10', metric: '4.5'),
        referenceImageId: 'img1'),
    Cat(id: '2', name: 'Perro', weight: Weight(imperial: '12', metric: '5.5')),
  ];

  setUp(() {
    mockRepo = MockCatRepository();
    provider = CatProvider(repository: mockRepo);
    when(mockRepo.getCats(limit: 10, page: 0))
        .thenAnswer((_) => Future.value(cats));
  });

  test('fetchCats debe poblar la lista de gatos', () async {
    await provider.fetchCats();
    expect(provider.cats.length, 2);
    expect(provider.cats.first.name, 'Gato');
    expect(provider.isLoading, false);
  });

  test('searchCats filtra correctamente', () async {
    await provider.fetchCats();
    provider.searchCats('gat');
    expect(provider.cats.length, 1);
    expect(provider.cats.first.name, 'Gato');
  });
}
