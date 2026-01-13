import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:module_1/pages/dashboard_screen.dart';

void main() {
  group('NotificationBadge', () {

    testWidgets('badge label is visible and styled appropriately', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NotificationBadge(count: 21,),
          ),
        ),
      );

      // Find the Text widget inside the Badge label
      final textFinder = find.descendant(
        of: find.byType(Badge),
        matching: find.byType(Text),
      );

      expect(textFinder, findsOneWidget);

      final textWidget = tester.widget<Text>(textFinder);
      expect(textWidget.data, '21');

    });

    testWidgets('displays the provided number of notifications', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NotificationBadge(count: 21),
          ),
        ),
      );

      expect(find.text('21'), findsOneWidget);

      // Test with different value
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NotificationBadge(count: 3),
          ),
        ),
      );

      expect(find.text('3'), findsOneWidget);
    });
  });
}