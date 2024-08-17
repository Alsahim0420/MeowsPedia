// test/widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meows_pedia/main.dart';

void main() {
  testWidgets('Search input and list view test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Search by name'), findsOneWidget);
    expect(find.byType(ListView), findsNothing);

    // Simulate typing in the search field
    await tester.enterText(find.byType(TextField), 'Siamese');
    await tester.pump();

    // Expect ListView to be present after typing
    expect(find.byType(ListView), findsOneWidget);
  });
}
