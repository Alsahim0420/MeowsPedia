import 'package:flutter_test/flutter_test.dart';
import 'package:meows_pedia/domain/entities/cat.dart';

void main() {
  group('Cat Entity', () {
    test('Debe crear una instancia correctamente', () {
      final weight = Weight(imperial: '10', metric: '4.5');
      final image = CatImage(id: 'img1', url: 'http://url.com');
      final cat = Cat(
        id: '1',
        name: 'Gato',
        weight: weight,
        image: image,
      );
      expect(cat.id, '1');
      expect(cat.name, 'Gato');
      expect(cat.weight.imperial, '10');
      expect(cat.image, isNotNull);
      expect(cat.image!.url, 'http://url.com');
    });
    test('setImage actualiza la imagen', () {
      final cat = Cat(
        id: '1',
        name: 'Gato',
        weight: Weight(imperial: '10', metric: '4.5'),
      );
      final newImage = CatImage(id: 'img2', url: 'http://nuevo.com');
      cat.setImage(newImage);
      expect(cat.image, isNotNull);
      expect(cat.image!.id, 'img2');
    });
  });

  group('Weight', () {
    test('Debe crear una instancia correctamente', () {
      final weight = Weight(imperial: '10', metric: '4.5');
      expect(weight.imperial, '10');
      expect(weight.metric, '4.5');
    });
  });

  group('CatImage', () {
    test('Debe crear una instancia correctamente', () {
      final image = CatImage(id: 'img1', url: 'http://url.com');
      expect(image.id, 'img1');
      expect(image.url, 'http://url.com');
    });
  });
}
