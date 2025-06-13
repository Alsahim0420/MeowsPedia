import 'package:flutter_test/flutter_test.dart';
import 'package:meows_pedia/data/models/cat_model.dart';
import 'package:meows_pedia/data/mappers/cat_mapper.dart';

void main() {
  test('CatModel.toEntity convierte correctamente', () {
    final model = CatModel(
      id: '1',
      name: 'Gato',
      weight: WeightModel(imperial: '10', metric: '4.5'),
    );
    final entity = model.toEntity();
    expect(entity.id, '1');
    expect(entity.name, 'Gato');
    expect(entity.weight.imperial, '10');
    expect(entity.weight.metric, '4.5');
  });
}
