import 'package:flutter_test/flutter_test.dart';
import 'package:meows_pedia/domain/entities/cat.dart';
import 'package:meows_pedia/domain/usecases/get_cats_usecase.dart';
import 'package:meows_pedia/domain/repositories/cat_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'get_cats_usecase_test.mocks.dart';

@GenerateMocks([CatRepository])
void main() {
  group('GetCatsUseCase', () {
    test('debe retornar una lista de gatos desde el repositorio', () async {
      final mockRepo = MockCatRepository();
      final cats = [
        Cat(
            id: '1',
            name: 'Gato',
            weight: Weight(imperial: '10', metric: '4.5')),
      ];
      when(mockRepo.getCats(limit: 10, page: 0))
          .thenAnswer((_) => Future.value(cats));
      final usecase = GetCatsUseCase(mockRepo);
      final result = await usecase();
      expect(result, cats);
      verify(mockRepo.getCats()).called(1);
    });
  });
}
