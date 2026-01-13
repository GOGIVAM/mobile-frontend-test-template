String formatDate(DateTime? date) {
  if (date == null) return '';
  final month = date.month.toString().padLeft(2, '0');
  final day = date.day.toString().padLeft(2, '0');
  final year = date.year.toString();
  return '$month/$day/$year';
}