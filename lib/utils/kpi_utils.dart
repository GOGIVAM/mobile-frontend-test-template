double calculateTotals(List<double> values) {
  return values.fold(0, (sum, item) => sum + item);
}
