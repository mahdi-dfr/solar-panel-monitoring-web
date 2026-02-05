
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solar_web/constants/app_bindings.dart';

import 'features/authentication/view/screens/login_screen.dart';

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
      theme: ThemeData(fontFamily: 'Shabnam'),
      initialBinding: AppBindings(),
      home:  SolarLoginPage(),
      locale: const Locale('fa', 'IR'),
    );
  }
}
