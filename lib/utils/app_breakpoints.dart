class AppBreakpoints {
  static const double mobile = 600.0;
  static const double tablet = 1024.0;

  static bool isMobile(double width) => width < mobile;
  static bool isTablet(double width) => width >= mobile && width < tablet;
  static bool isDesktop(double width) => width >= tablet;
}