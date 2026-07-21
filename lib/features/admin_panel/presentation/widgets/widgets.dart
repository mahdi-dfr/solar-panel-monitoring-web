import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/constant.dart';
import '../../../../constants/resource.dart';
import '../../data/model/admin_panel_model.dart';

class AdminSidebar extends StatelessWidget {
  final int selectedIndex;
  final List<AdminMenuItem> menuItems;
  final ValueChanged<int> onMenuSelected;

  const AdminSidebar({
    super.key,
    required this.selectedIndex,
    required this.menuItems,
    required this.onMenuSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      margin: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: CustomAppColors.borderColor,
        ),
      ),
      child: Column(
        children: [
          const AdminProfileHeader(),

          const Divider(
            height: 1,
            color: CustomAppColors.borderColor,
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 18,
              ),
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                return AdminSidebarItem(
                  title: menuItems[index].title,
                  icon: menuItems[index].icon,
                  isSelected: selectedIndex == index,
                  onTap: () {
                    onMenuSelected(index);
                  },
                );
              },
            ),
          ),

          const SidebarFooter(),
        ],
      ),
    );
  }
}




class AdminProfileHeader extends StatelessWidget {
  const AdminProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: CustomAppColors.lightGreenColor,
            ),
            child: const Icon(
              Icons.person_outline,
              color: CustomAppColors.primaryColor,
              size: 28,
            ),
          ),

          const SizedBox(width: 12),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'مدیر سیستم',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: CustomAppColors.textColor,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'admin',
                  style: TextStyle(
                    fontSize: 12,
                    color: CustomAppColors.secondaryTextColor,
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.keyboard_arrow_down,
            color: CustomAppColors.secondaryTextColor,
          ),
        ],
      ),
    );
  }
}





class AdminSidebarItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const AdminSidebarItem({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              color: isSelected
                  ? CustomAppColors.primaryColor
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 21,
                  color: isSelected
                      ? Colors.white
                      : CustomAppColors.secondaryTextColor,
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: isSelected
                          ? Colors.white
                          : CustomAppColors.textColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





class SidebarFooter extends StatelessWidget {
  const SidebarFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: CustomAppColors.lightGreenColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                Image.asset(AppConstants.logo, width: context.width / 22),

                SizedBox(height: 8),

                Text(
                  'سامانه مانیتورینگ\nپنل‌های خورشیدی',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: CustomAppColors.primaryDarkColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // const Text(
          //   'نسخه 1.0.0',
          //   style: TextStyle(
          //     fontSize: 11,
          //     color: CustomAppColors.secondaryTextColor,
          //   ),
          // ),
        ],
      ),
    );
  }
}


class AdminContentArea extends StatelessWidget {
  final int selectedIndex;

  const AdminContentArea({
    super.key,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 1600,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AdminPageHeader(),

            const SizedBox(height: 28),

            _buildSelectedPage(),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedPage() {
    switch (selectedIndex) {
      case 1:
        return const UsersManagementPage();

      case 2:
        return const ProjectsManagementPage();

      case 3:
        return const BoardsManagementPage();

      case 4:
        return const StringsManagementPage();

      default:
        return const DashboardPage();
    }
  }
}



class AdminPageHeader extends StatelessWidget {
  const AdminPageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: CustomAppColors.lightGreenColor,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(
            Icons.admin_panel_settings_outlined,
            color: CustomAppColors.primaryColor,
            size: 28,
          ),
        ),

        const SizedBox(width: 14),

        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'پنل مدیریت',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: CustomAppColors.textColor,
                ),
              ),

              SizedBox(height: 6),

              Text(
                'مدیریت کاربران، پروژه‌ها، بردها و استرینگ‌های سیستم',
                style: TextStyle(
                  fontSize: 14,
                  color: CustomAppColors.secondaryTextColor,
                ),
              ),
            ],
          ),
        ),


      ],
    );
  }
}




class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.count(
          crossAxisCount: _getCrossAxisCount(
            constraints.maxWidth,
          ),
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          childAspectRatio: 2.2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            DashboardStatCard(
              title: 'تعداد کاربران',
              value: '128',
              icon: Icons.people_outline,
            ),
            DashboardStatCard(
              title: 'تعداد پروژه‌ها',
              value: '42',
              icon: Icons.folder_outlined,
            ),
            DashboardStatCard(
              title: 'تعداد بردها',
              value: '96',
              icon: Icons.memory_outlined,
            ),
            DashboardStatCard(
              title: 'تعداد استرینگ‌ها',
              value: '384',
              icon: Icons.show_chart_outlined,
            ),
          ],
        );
      },
    );
  }

  int _getCrossAxisCount(double width) {
    if (width >= 1200) {
      return 4;
    }

    if (width >= 800) {
      return 2;
    }

    return 1;
  }
}



class DashboardStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const DashboardStatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: CustomAppColors.cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: CustomAppColors.borderColor,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: CustomAppColors.lightGreenColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              icon,
              color: CustomAppColors.primaryColor,
              size: 28,
            ),
          ),

          const SizedBox(width: 16),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  color: CustomAppColors.secondaryTextColor,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: CustomAppColors.textColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



class UsersManagementPage extends StatelessWidget {
  const UsersManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ManagementHeader(
          title: 'مدیریت کاربران',
          description: 'ایجاد و مدیریت کاربران سیستم',
          buttonText: 'ایجاد کاربر جدید',
          icon: Icons.person_add_alt_1_outlined,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return const CreateUserDialog();
              },
            );
          },
        ),

        const SizedBox(height: 24),

        const ManagementTableCard(
          title: 'آخرین کاربران',
          columns: [
            'نام',
            'نام خانوادگی',
            'نام کاربری',
            'شماره موبایل',
            'نقش',
            'عملیات',
          ],
        ),
      ],
    );
  }
}




class ProjectsManagementPage extends StatelessWidget {
  const ProjectsManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ManagementHeader(
          title: 'مدیریت پروژه‌ها',
          description: 'ایجاد و مدیریت پروژه‌های کاربران',
          buttonText: 'ایجاد پروژه جدید',
          icon: Icons.create_new_folder_outlined,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return const CreateProjectDialog();
              },
            );
          },
        ),

        const SizedBox(height: 24),

        const ManagementTableCard(
          title: 'پروژه‌های اخیر',
          columns: [
            'نام پروژه',
            'کاربر',
            'شهر',
            'آدرس پروژه',
            'عملیات',
          ],
        ),
      ],
    );
  }
}





class BoardsManagementPage extends StatelessWidget {
  const BoardsManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ManagementHeader(
          title: 'مدیریت بردها',
          description: 'ساخت برد برای پروژه‌های موجود',
          buttonText: 'ایجاد برد جدید',
          icon: Icons.memory_outlined,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return const CreateBoardDialog();
              },
            );
          },
        ),

        const SizedBox(height: 24),

        const ManagementTableCard(
          title: 'بردهای اخیر',
          columns: [
            'نام برد',
            'شناسه برد',
            'پروژه',
            'تعداد استرینگ',
            'عملیات',
          ],
        ),
      ],
    );
  }
}





class StringsManagementPage extends StatelessWidget {
  const StringsManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ManagementHeader(
          title: 'مدیریت استرینگ‌ها',
          description: 'ساخت و مدیریت استرینگ‌های بردها',
          buttonText: 'ایجاد استرینگ جدید',
          icon: Icons.show_chart_outlined,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return const CreateStringDialog();
              },
            );
          },
        ),

        const SizedBox(height: 24),

        const ManagementTableCard(
          title: 'استرینگ‌های اخیر',
          columns: [
            'نام استرینگ',
            'شناسه',
            'برد',
            'پروژه',
            'عملیات',
          ],
        ),
      ],
    );
  }
}





class ManagementHeader extends StatelessWidget {
  final String title;
  final String description;
  final String buttonText;
  final IconData icon;
  final VoidCallback onPressed;

  const ManagementHeader({
    super.key,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: CustomAppColors.borderColor,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool isSmall = constraints.maxWidth < 600;

          if (isSmall) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTitle(),

                const SizedBox(height: 20),

                _buildButton(),
              ],
            );
          }

          return Row(
            children: [
              Expanded(
                child: _buildTitle(),
              ),

              const SizedBox(width: 20),

              _buildButton(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            color: CustomAppColors.textColor,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          description,
          style: const TextStyle(
            fontSize: 13,
            color: CustomAppColors.secondaryTextColor,
          ),
        ),
      ],
    );
  }

  Widget _buildButton() {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(buttonText),
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomAppColors.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}





class ManagementTableCard extends StatelessWidget {
  final String title;
  final List<String> columns;

  const ManagementTableCard({
    super.key,
    required this.title,
    required this.columns,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: CustomAppColors.borderColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: CustomAppColors.textColor,
            ),
          ),

          const SizedBox(height: 20),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 40,
              headingRowColor: WidgetStateProperty.all(
                CustomAppColors.backgroundColor,
              ),
              columns: columns
                  .map(
                    (column) => DataColumn(
                  label: Text(
                    column,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              )
                  .toList(),
              rows: const [],
            ),
          ),
        ],
      ),
    );
  }
}





class CreateUserDialog extends StatelessWidget {
  const CreateUserDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 650,
        ),
        child: Container(
          padding: const EdgeInsets.all(26),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const DialogTitle(
                  title: 'ایجاد کاربر جدید',
                  icon: Icons.person_add_alt_1_outlined,
                ),

                const SizedBox(height: 24),

                ResponsiveFormGrid(
                  children: [
                    AppTextField(
                      label: 'نام',
                      hint: 'نام را وارد کنید',
                    ),

                    AppTextField(
                      label: 'نام خانوادگی',
                      hint: 'نام خانوادگی را وارد کنید',
                    ),

                    AppTextField(
                      label: 'شماره موبایل',
                      hint: '0912...',
                    ),

                    AppDropdownField(
                      label: 'نقش کاربر',
                      hint: 'انتخاب نقش',
                      items: const [
                        'کاربر عادی',
                        'ادمین',
                      ],
                    ),

                    AppTextField(
                      label: 'نام کاربری',
                      hint: 'نام کاربری را وارد کنید',
                    ),

                    AppTextField(
                      label: 'رمز عبور',
                      hint: 'رمز عبور را وارد کنید',
                      obscureText: true,
                    ),

                    AppDropdownField(
                      label: 'شهر محل سکونت',
                      hint: 'انتخاب شهر',
                      items: const [
                        'کاشان',
                        'اصفهان',
                        'تهران',
                      ],
                    ),

                    AppTextField(
                      label: 'آدرس',
                      hint: 'آدرس را وارد کنید',
                      maxLines: 3,
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                PrimaryButton(
                  title: 'ایجاد کاربر',
                  icon: Icons.person_add_alt_1,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





class CreateProjectDialog extends StatelessWidget {
  const CreateProjectDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 600,
        ),
        child: Container(
          padding: const EdgeInsets.all(26),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const DialogTitle(
                  title: 'ایجاد پروژه جدید',
                  icon: Icons.create_new_folder_outlined,
                ),

                const SizedBox(height: 24),

                AppDropdownField(
                  label: 'کاربر مربوط به پروژه',
                  hint: 'انتخاب کاربر',
                  items: const [
                    'کاربر اول',
                    'کاربر دوم',
                    'کاربر سوم',
                  ],
                ),

                const SizedBox(height: 16),

                AppTextField(
                  label: 'نام پروژه',
                  hint: 'نام پروژه را وارد کنید',
                ),

                const SizedBox(height: 16),

                AppTextField(
                  label: 'آدرس پروژه',
                  hint: 'آدرس پروژه را وارد کنید',
                  maxLines: 3,
                ),

                const SizedBox(height: 24),

                PrimaryButton(
                  title: 'ایجاد پروژه',
                  icon: Icons.add,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





class CreateBoardDialog extends StatelessWidget {
  const CreateBoardDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 600,
        ),
        child: Container(
          padding: const EdgeInsets.all(26),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const DialogTitle(
                  title: 'ایجاد برد جدید',
                  icon: Icons.memory_outlined,
                ),

                const SizedBox(height: 24),

                AppDropdownField(
                  label: 'پروژه مربوطه',
                  hint: 'انتخاب پروژه',
                  items: const [
                    'پروژه نیروگاه کاشان',
                    'پروژه منزل اصفهان',
                  ],
                ),

                const SizedBox(height: 16),

                AppTextField(
                  label: 'نام برد',
                  hint: 'نام برد را وارد کنید',
                ),

                const SizedBox(height: 16),

                AppTextField(
                  label: 'شناسه برد',
                  hint: 'Board ID را وارد کنید',
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 24),

                PrimaryButton(
                  title: 'ایجاد برد',
                  icon: Icons.memory_outlined,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




class CreateStringDialog extends StatelessWidget {
  const CreateStringDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 600,
        ),
        child: Container(
          padding: const EdgeInsets.all(26),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const DialogTitle(
                  title: 'ایجاد استرینگ جدید',
                  icon: Icons.show_chart_outlined,
                ),

                const SizedBox(height: 24),

                AppDropdownField(
                  label: 'برد مربوطه',
                  hint: 'انتخاب برد',
                  items: const [
                    'برد اصلی',
                    'برد فرعی ۱',
                    'برد فرعی ۲',
                  ],
                ),

                const SizedBox(height: 16),

                AppTextField(
                  label: 'نام استرینگ',
                  hint: 'نام استرینگ را وارد کنید',
                ),

                const SizedBox(height: 16),

                AppTextField(
                  label: 'شناسه استرینگ',
                  hint: 'String ID را وارد کنید',
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 24),

                PrimaryButton(
                  title: 'ایجاد استرینگ',
                  icon: Icons.show_chart_outlined,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





class DialogTitle extends StatelessWidget {
  final String title;
  final IconData icon;

  const DialogTitle({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: CustomAppColors.lightGreenColor,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(
            icon,
            color: CustomAppColors.primaryColor,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: CustomAppColors.textColor,
            ),
          ),
        ),

        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
            color: CustomAppColors.secondaryTextColor,
          ),
        ),
      ],
    );
  }
}





class ResponsiveFormGrid extends StatelessWidget {
  final List<Widget> children;

  const ResponsiveFormGrid({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isWide = constraints.maxWidth >= 600;

        if (!isWide) {
          return Column(
            children: children
                .map(
                  (child) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: child,
              ),
            )
                .toList(),
          );
        }

        return GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 4.2,
          children: children,
        );
      },
    );
  }
}




class AppTextField extends StatelessWidget {
  final String label;
  final String hint;
  final bool obscureText;
  final int maxLines;
  final TextInputType? keyboardType;

  const AppTextField({
    super.key,
    required this.label,
    required this.hint,
    this.obscureText = false,
    this.maxLines = 1,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: CustomAppColors.textColor,
          ),
        ),

        const SizedBox(height: 8),

        TextField(
          obscureText: obscureText,
          maxLines: obscureText ? 1 : maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              fontSize: 12,
              color: CustomAppColors.secondaryTextColor,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: CustomAppColors.borderColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: CustomAppColors.borderColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: CustomAppColors.primaryColor,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}





class AppDropdownField extends StatelessWidget {
  final String label;
  final String hint;
  final List<String> items;

  const AppDropdownField({
    super.key,
    required this.label,
    required this.hint,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: CustomAppColors.textColor,
          ),
        ),

        const SizedBox(height: 8),

        DropdownButtonFormField<String>(
          hint: Text(
            hint,
            style: const TextStyle(
              fontSize: 12,
              color: CustomAppColors.secondaryTextColor,
            ),
          ),
          items: items
              .map(
                (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            ),
          )
              .toList(),
          onChanged: (value) {},
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 4,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: CustomAppColors.borderColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: CustomAppColors.borderColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}





class PrimaryButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  const PrimaryButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(title),
        style: ElevatedButton.styleFrom(
          backgroundColor: CustomAppColors.primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}




class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const EmptyAdminPage(
      title: 'گزارش‌ها',
      icon: Icons.bar_chart_outlined,
    );
  }
}



class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const EmptyAdminPage(
      title: 'تنظیمات',
      icon: Icons.settings_outlined,
    );
  }
}


class EmptyAdminPage extends StatelessWidget {
  final String title;
  final IconData icon;

  const EmptyAdminPage({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: CustomAppColors.borderColor,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 52,
              color: CustomAppColors.primaryColor,
            ),

            const SizedBox(height: 16),

            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}




class MobileTopBar extends StatelessWidget {
  final VoidCallback onMenuPressed;

  const MobileTopBar({
    super.key,
    required this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: CustomAppColors.borderColor,
          ),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onMenuPressed,
            icon: const Icon(Icons.menu),
          ),

          const SizedBox(width: 8),

          const Text(
            'پنل مدیریت',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),

          const Spacer(),

          const Icon(
            Icons.solar_power_outlined,
            color: CustomAppColors.primaryColor,
          ),
        ],
      ),
    );
  }
}




class MobileMenuDialog extends StatelessWidget {
  final int selectedIndex;
  final List<AdminMenuItem> menuItems;
  final ValueChanged<int> onMenuSelected;

  const MobileMenuDialog({
    super.key,
    required this.selectedIndex,
    required this.menuItems,
    required this.onMenuSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.centerRight,
      insetPadding: EdgeInsets.zero,
      child: SizedBox(
        width: 280,
        height: double.infinity,
        child: Column(
          children: [
            const AdminProfileHeader(),

            const Divider(),

            Expanded(
              child: ListView.builder(
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  return AdminSidebarItem(
                    title: menuItems[index].title,
                    icon: menuItems[index].icon,
                    isSelected: selectedIndex == index,
                    onTap: () {
                      onMenuSelected(index);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}







