import 'package:flutter_test/flutter_test.dart';
import 'package:meows_pedia/data/models/cat_model.dart';

void main() {
  test('CatModel.fromJson parsea correctamente', () {
    final json = {
      'id': '1',
      'name': 'Gato',
      'weight': {'imperial': '10', 'metric': '4.5'},
    };
    final model = CatModel.fromJson(json);
    expect(model.id, '1');
    expect(model.name, 'Gato');
    expect(model.weight.imperial, '10');
    expect(model.weight.metric, '4.5');
  });
  test('WeightModel.fromJson parsea correctamente', () {
    final json = {'imperial': '10', 'metric': '4.5'};
    final weight = WeightModel.fromJson(json);
    expect(weight.imperial, '10');
    expect(weight.metric, '4.5');
  });
}
