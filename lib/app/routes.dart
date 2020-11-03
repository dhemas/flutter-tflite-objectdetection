import 'package:flutter_tflite_object_detection/app/binding/home_page_binding.dart';
import 'package:flutter_tflite_object_detection/app/ui/home_page/home_page.dart';
import 'package:get/get.dart';

abstract class Routes {
  static const INITIAL = '/';
  static const HOME = '/home';
}

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomePageBinding(),
    ),
  ];
}
