import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.HOME,
      defaultTransition: Transition.fade,
      getPages: AppPages.pages,
    ),
  );
}
