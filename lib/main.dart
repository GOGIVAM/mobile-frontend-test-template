import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_gogivam/routes/app_pages.dart';


void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //la page de depart est la page "mainPage"
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.mainPage,
      getPages: AppPages.routes,
    );
  }
}

