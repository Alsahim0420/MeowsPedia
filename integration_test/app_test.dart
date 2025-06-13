import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:meows_pedia/main.dart' as app;
import 'package:meows_pedia/presentation/presentation.dart';
import 'package:provider/provider.dart';
import '../test/mocks/mock_cat_repository.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('verify app flow', (tester) async {
      // Configurar el mock repository
      final mockRepository = MockCatRepository();

      // Iniciar la app con el mock repository
      app.main(repository: mockRepository);

      // Esperar a que la app se inicialice completamente
      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();

      // Verificar que estamos en la pantalla principal
      expect(find.text('MeowsPedia'), findsOneWidget);
      expect(find.byType(GridView), findsOneWidget);
      expect(find.byType(CatListItem),
          findsNWidgets(2)); // Deberíamos ver 2 gatos del mock

      // Probar la búsqueda
      await tester.tap(find.byIcon(Icons.search_outlined));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Verificar que estamos en la pantalla de búsqueda
      expect(find.byType(TextField), findsOneWidget);

      // Buscar un gato
      await tester.enterText(find.byType(TextField), 'Persian');
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Verificar que se muestra el resultado y seleccionar el gato
      final persianCard = find.ancestor(
        of: find.text('Persian'),
        matching: find.byType(Card),
      );
      expect(persianCard, findsOneWidget);
      await tester.tap(persianCard);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Verificar que estamos en la pantalla de detalles
      expect(find.text('Persian'), findsOneWidget);
      expect(find.text('Iran'), findsOneWidget);
      expect(find.text('Temperament'), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);
    });
  });
}
