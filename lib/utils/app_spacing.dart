class AppSpacing {
  // Mobile-first defaults
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;

  static const double cardRadius = 12.0;

  // Responsive scaling factors (you can adjust)
  static double getPaddingSmall(double screenWidth) => screenWidth < 600 ? 8.0 : 12.0;
  static double getPaddingMedium(double screenWidth) => screenWidth < 600 ? 16.0 : 24.0;
  static double getPaddingLarge(double screenWidth) => screenWidth < 600 ? 20.0 : 32.0;
}