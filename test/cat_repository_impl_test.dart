// ignore_for_file: cast_from_null_always_fails

import 'package:flutter_test/flutter_test.dart';
import 'package:meows_pedia/data/repositories/cat_repository_impl.dart';
import 'package:meows_pedia/domain/datasources/cat_remote_data_source.dart';
import 'package:meows_pedia/data/models/cat_model.dart';
import 'package:meows_pedia/domain/entities/cat.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'cat_repository_impl_test.mocks.dart';

@GenerateMocks([CatRemoteDataSource])
void main() {
  group('CatRepositoryImpl', () {
    test('debe retornar una lista de entidades Cat', () async {
      final mockDataSource = MockCatRemoteDataSource();
      final catModel = CatModel(
        id: '1',
        name: 'Gato',
        weight: WeightModel(imperial: '10', metric: '4.5'),
        referenceImageId: 'img1',
      );
      when(mockDataSource.fetchCats(limit: 10, page: 0))
          .thenAnswer((_) => Future.value([catModel]));
      when(mockDataSource.fetchCatImage(any))
          .thenAnswer((_) => Future.value('http://img.com'));
      final repo = CatRepositoryImpl(remoteDataSource: mockDataSource);
      final result = await repo.getCats();
      expect(result, isA<List<Cat>>());
      expect(result.first.name, 'Gato');
      expect(result.first.image, isNotNull);
    });
  });
}
