import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app.dart';

void main() {
  // Configurer GetX pour utiliser le mode d'URL du navigateur
  Get.config(
    enableLog: true,
    defaultTransition: Transition.fade,
    defaultOpaqueRoute: Get.isOpaqueRouteDefault,
    defaultPopGesture: Get.isPopGestureEnable,
    defaultDurationTransition: Get.defaultDialogTransitionDuration,
  );
  
  runApp(const MyApp());
}
