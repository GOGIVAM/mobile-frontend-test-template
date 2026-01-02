import 'package:get/get.dart';
import 'package:test_gogivam/pages/app.dart';


part 'app_routes.dart';

//route vers chaque pages
class AppPages {
  static final routes = [
    GetPage(
      name: Routes.mainPage, 
      page: ()=>MainPage()
    ),
  ];
}