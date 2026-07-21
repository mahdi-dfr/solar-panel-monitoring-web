import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import '../../data/model/admin_panel_model.dart';
import '../widgets/widgets.dart';

class AdminPanelPage extends StatefulWidget {
  const AdminPanelPage({super.key});

  @override
  State<AdminPanelPage> createState() => _AdminPanelPageState();
}

class _AdminPanelPageState extends State<AdminPanelPage> {
  int selectedMenuIndex = 0;

  final List<AdminMenuItem> menuItems = [
    AdminMenuItem(
      title: 'داشبورد',
      icon: Icons.dashboard_outlined,
    ),
    AdminMenuItem(
      title: 'مدیریت کاربران',
      icon: Icons.people_outline,
    ),
    AdminMenuItem(
      title: 'مدیریت پروژه‌ها',
      icon: Icons.folder_outlined,
    ),
    AdminMenuItem(
      title: 'مدیریت بردها',
      icon: Icons.memory_outlined,
    ),
    AdminMenuItem(
      title: 'مدیریت استرینگ‌ها',
      icon: Icons.show_chart_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: CustomAppColors.backgroundColor,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final bool isMobile = constraints.maxWidth < 850;

            return Row(
              children: [
                if (!isMobile)
                  AdminSidebar(
                    selectedIndex: selectedMenuIndex,
                    menuItems: menuItems,
                    onMenuSelected: (index) {
                      setState(() {
                        selectedMenuIndex = index;
                      });
                    },
                  ),
                Expanded(
                  child: Column(
                    children: [
                      if (isMobile)
                        MobileTopBar(
                          onMenuPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return MobileMenuDialog(
                                  selectedIndex: selectedMenuIndex,
                                  menuItems: menuItems,
                                  onMenuSelected: (index) {
                                    setState(() {
                                      selectedMenuIndex = index;
                                    });

                                    Navigator.pop(context);
                                  },
                                );
                              },
                            );
                          },
                        ),
                      Expanded(
                        child: AdminContentArea(
                          selectedIndex: selectedMenuIndex,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}