
double calculatePercentChange({
  required double current,
  required double previous,
}) {
  if (previous == 0) {
    return current == 0 ? 0.0 : (current > 0 ? double.infinity : double.negativeInfinity);
  }
  final percent = ((current - previous) / previous) * 100;
  return double.parse(percent.toStringAsFixed(10)); // or .toStringAsFixed(4)
}