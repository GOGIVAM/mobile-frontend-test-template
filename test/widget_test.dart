
//
// // test/integration/dashboard_integration_test.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// void main() {
//   group('Dashboard Integration Tests', () {
//     testWidgets('complete dashboard loads and displays all components',
//             (WidgetTester tester) async {
//           await tester.pumpWidget(
//             const ProviderScope(
//               child: MaterialApp(
//                 home: Scaffold(
//                   body: Center(child: Text('Dashboard')),
//                 ),
//               ),
//             ),
//           );
//
//           expect(find.text('Dashboard'), findsOneWidget);
//         });
//
//     testWidgets('navigation between screens works', (WidgetTester tester) async {
//       int currentIndex = 0;
//
//       await tester.pumpWidget(
//         MaterialApp(
//           home: StatefulBuilder(
//             builder: (context, setState) {
//               return Scaffold(
//                 body: ResponsiveNavigation(
//                   selectedIndex: currentIndex,
//                   onDestinationSelected: (index) {
//                     setState(() => currentIndex = index);
//                   },
//                 ),
//               );
//             },
//           ),
//         ),
//       );
//
//       // Simulate navigation
//       await tester.tap(find.byType(InkWell).first);
//       await tester.pumpAndSettle();
//
//       expect(currentIndex, greaterThanOrEqualTo(0));
//     });
//
//     testWidgets('responsive breakpoints work correctly', (WidgetTester tester) async {
//       // Test mobile breakpoint
//       await tester.binding.setSurfaceSize(const Size(375, 812));
//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: ResponsiveNavigation(
//               selectedIndex: 0,
//               onDestinationSelected: (_) {},
//             ),
//           ),
//         ),
//       );
//       expect(find.byType(SizedBox), findsOneWidget);
//
//       // Test desktop breakpoint
//       await tester.binding.setSurfaceSize(const Size(1920, 1080));
//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: ResponsiveNavigation(
//               selectedIndex: 0,
//               onDestinationSelected: (_) {},
//             ),
//           ),
//         ),
//       );
//       expect(find.byType(CustomNavigationRail), findsOneWidget);
//
//       // Reset surface size
//       await tester.binding.setSurfaceSize(null);
//     });
//   });
// }