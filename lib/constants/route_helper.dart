
import 'package:get/get.dart';
import 'package:solar_web/features/dashboard/presentation/screens/dashboard_view.dart';
import 'package:solar_web/features/dashboard/presentation/screens/projects_screen.dart';

import '../features/authentication/presentation/screens/login_screen.dart';
import '../features/dashboard/presentation/screens/hitmap_screen.dart';

class RouteHelper {
  static const String _login = '/';
  static const String _project = '/home';
  static const String _dashboard = '/base_page';
  static const String _hitmap = '/admin_home';


  static String get project => _project;

  static String get dashboard => _dashboard;

  static String get hitmap => _hitmap;

  static String get login => _login;


  static List<GetPage> routes = [
    GetPage(name: _login, page: () => SolarLoginPage()),
    GetPage(name: _project, page: () => ProjectsListPage()),
    GetPage(name: _dashboard, page: () => DashboardPage()),
    GetPage(name: _hitmap, page: () => PanelOverviewPage()),
  ];


}
