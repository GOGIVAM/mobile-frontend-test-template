import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_gogivam/controllers/app_controller.dart';
import 'package:test_gogivam/pages/drawer.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppController());

    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Row(
            children: [
              Text("Hello world")
            ],
          ),
        )),
      );
  }
}