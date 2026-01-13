import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app.dart';
import 'providers/dashboard_provider.dart';
import 'providers/order_provider.dart';
import 'providers/kpi_provider.dart';

void main() {
  // Initialize providers
  Get.put(DashboardProvider());
  Get.put(OrderProvider());
  Get.put(KpiProvider());

  runApp(const MyApp());
}
