import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_frontend_test_template/widgets/notification_badge.dart';

void main() {
  testWidgets('NotificationBadge displays the correct highlighted text', (WidgetTester tester) async {
    const baseText = 'You have ';
    const highlightedText = '21 new leads';

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: NotificationBadge(
            text: baseText,
            highlightedText: highlightedText,
          ),
        ),
      ),
    );

    // Verify both parts of the text are found
    expect(find.textContaining(baseText), findsOneWidget);
    expect(find.textContaining(highlightedText), findsOneWidget);
  });
}
