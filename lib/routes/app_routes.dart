import 'package:get/get.dart';
import '../pages/dashboard_screen.dart';
import '../pages/analytics_screen.dart';
import '../pages/reports_screen.dart';
import '../pages/products_screen.dart';
import '../pages/calendar_screen.dart';

class AppRoutes {
  static const String dashboard = '/dashboard';
  static const String analytics = '/analytics';
  static const String reports = '/reports';
  static const String products = '/products';
  static const String calendar = '/calendar';

  static List<GetPage> getPages = [
    GetPage(
      name: dashboard,
      page: () => const DashboardScreen(),
    ),
    GetPage(
      name: analytics,
      page: () => const AnalyticsScreen(),
    ),
    GetPage(
      name: reports,
      page: () => const ReportsScreen(),
    ),
    GetPage(
      name: products,
      page: () => const ProductsScreen(),
    ),
    GetPage(
      name: calendar,
      page: () => const CalendarScreen(),
    ),
  ];
}

