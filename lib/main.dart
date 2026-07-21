
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:solar_web/constants/app_bindings.dart';
import 'package:solar_web/constants/constant.dart';
import 'package:solar_web/features/admin_panel/presentation/screens/admin_panel_page.dart';

import 'constants/route_helper.dart';
import 'features/authentication/view/screens/login_screen.dart';
import 'features/dashboard/presentation/screens/projects_screen.dart';

 main() async {
  await GetStorage.init();
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
      getPages: RouteHelper.routes,
      // initialRoute: GetStorage().read(AppConstants.accessToken) == null
      //       ? RouteHelper.login : RouteHelper.project,
      home: AdminPanelPage(),
      //     ? SolarLoginPage() : ProjectsListPage(),
      // home:  ProjectsListPage(),
      locale: const Locale('fa', 'IR'),
    );
  }
}
