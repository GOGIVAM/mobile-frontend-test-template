import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:module_1/utils/app_colors.dart';
import 'package:module_1/widgets/kpi_card.dart';

void main() {
  group('KpiCard Widget Tests', () {
    testWidgets('renders all required elements', (WidgetTester tester) async {
      // Arrange
      const title = 'Total Sales';
      const value = '1,234';
      const color = Colors.blue;
      const icon = Icons.shopping_cart;
      const changePercentage = 12.5;

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: KpiCard(
              title: title,
              value: value,
              color: color,
              icon: icon,
              changePercentage: changePercentage,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(title), findsOneWidget);
      expect(find.text(value), findsOneWidget);
      expect(find.byIcon(icon), findsOneWidget);
      expect(find.byType(CircleAvatar), findsOneWidget);
    });

    testWidgets('applies correct styling to title and value', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: KpiCard(
              title: 'Revenue',
              value: '\$5,000',
              color: Colors.green,
              icon: Icons.attach_money,
              changePercentage: 8.0,
            ),
          ),
        ),
      );

      final valueFinder = find.text('\$5,000');
      final valueWidget = tester.widget<Text>(valueFinder);

      expect(valueWidget.style?.fontSize, 28);
      expect(valueWidget.style?.fontWeight, FontWeight.bold);
      expect(valueWidget.style?.color, Colors.green);

      final titleFinder = find.text('Revenue');
      final titleWidget = tester.widget<Text>(titleFinder);

      expect(titleWidget.style?.fontSize, 16);
    });

    testWidgets('has correct container dimensions and decoration', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: KpiCard(
              title: 'Orders',
              value: '456',
              color: Colors.orange,
              icon: Icons.receipt,
              changePercentage: 5.0,
            ),
          ),
        ),
      );

      final containerFinder = find.byType(Container).first;
      final container = tester.widget<Container>(containerFinder);

      final decoration = container.decoration as BoxDecoration?;
      expect(decoration?.borderRadius, BorderRadius.circular(8));
      expect(decoration?.color, AppColors.cardBg);
    });

    testWidgets('icon is rendered inside CircleAvatar with correct colors',
            (WidgetTester tester) async {
          const testColor = Color(0xFF6B8DE3);

          await tester.pumpWidget(
            const MaterialApp(
              home: Scaffold(
                body: KpiCard(
                  title: 'Users',
                  value: '789',
                  color: testColor,
                  icon: Icons.people,
                  changePercentage: 3.5,
                ),
              ),
            ),
          );

          final avatarFinder = find.byType(CircleAvatar);
          final avatar = tester.widget<CircleAvatar>(avatarFinder);

          expect(avatar.backgroundColor, testColor);

          final iconFinder = find.byIcon(Icons.people);
          final iconWidget = tester.widget<Icon>(iconFinder);
          expect(iconWidget.color, AppColors.cardBg);
        });

    testWidgets('displays different KPI types correctly', (WidgetTester tester) async {
      final kpiData = [
        {'title': 'Sales', 'value': '1.2K', 'color': Colors.blue, 'icon': Icons.trending_up},
        {'title': 'Revenue', 'value': '\$45K', 'color': Colors.green, 'icon': Icons.attach_money},
        {'title': 'Orders', 'value': '234', 'color': Colors.orange, 'icon': Icons.receipt},
      ];

      for (var data in kpiData) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: KpiCard(
                title: data['title'] as String,
                value: data['value'] as String,
                color: data['color'] as Color,
                icon: data['icon'] as IconData,
                changePercentage: 10.0,
              ),
            ),
          ),
        );

        expect(find.text(data['title'] as String), findsOneWidget);
        expect(find.text(data['value'] as String), findsOneWidget);
        expect(find.byIcon(data['icon'] as IconData), findsOneWidget);
      }
    });

    testWidgets('layout uses Row with correct spacing', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: KpiCard(
              title: 'Test',
              value: '100',
              color: Colors.blue,
              icon: Icons.star,
              changePercentage: 5.0,
            ),
          ),
        ),
      );

      final rowFinder = find.byType(Row);
      expect(rowFinder, findsOneWidget);

      final row = tester.widget<Row>(rowFinder);
      expect(row.mainAxisSize, MainAxisSize.min);
    });
  });
}