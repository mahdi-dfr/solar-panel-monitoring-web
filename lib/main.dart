
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solar_web/constants/app_bindings.dart';

import 'core/view/screens/dashboard_view.dart';
import 'core/view/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Solar Monitoring Web',
      debugShowCheckedModeBanner: false,
      initialBinding: AppBindings(),
      home:  SolarLoginPage(),
      locale: const Locale('fa', 'IR'),
    );
  }
}
