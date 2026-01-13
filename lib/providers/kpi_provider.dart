import 'package:get/get.dart';

class KpiProvider extends GetxController {
  // Reactive KPI values
  final sales = '0'.obs;
  final customers = '0'.obs;
  final products = '0'.obs;
  final revenue = '0'.obs;

  @override
  void onInit() {
    super.onInit();
    calculateKpis();
  }

  // Performs logic/calculations on the metrics
  void calculateKpis() {
    // Mock calculation logic
    sales.value = '250k';
    customers.value = '24m';
    products.value = '15k';
    revenue.value = '180m';
  }
}
