import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_frontend_test_template/widgets/kpi_card.dart';

void main() {
  testWidgets('KpiCard displays the correct value and title', (WidgetTester tester) async {
    const testValue = '250k';
    const testTitle = 'Sales';

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: KpiCard(
            title: testTitle,
            value: testValue,
            icon: Icons.bar_chart,
            iconColor: Colors.orange,
            iconBackgroundColor: Colors.orangeAccent,
          ),
        ),
      ),
    );

    expect(find.text(testValue), findsOneWidget);
    expect(find.text(testTitle), findsOneWidget);
  });
}
