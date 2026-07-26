import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solar_web/constants/app_colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../constants/constant.dart';
import '../../../../constants/route_helper.dart';
import '../../domain/entities/chart_entity.dart';
import '../../domain/entities/live_string_entity.dart';
import '../controller/dashboard_controller.dart';


class SolarRadianceCard extends GetView<DashboardController> {
  const SolarRadianceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return _BaseCard(
      title: "میزان ولتاژ",
      subtitle: "میانگین ولتاژ در بازه انتخاب‌شده",
      child: Obx(() {

        final data = controller.chartData;

        if (data.isEmpty) {
          return const _EmptyChart();
        }

        return _ChartWrapper(
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),

            series: <CartesianSeries>[
              ColumnSeries<DashboardChartEntity, String>(
                dataSource: data,

                xValueMapper: (
                    DashboardChartEntity item,
                    _,
                    ) {
                  return item.date;
                },

                yValueMapper: (
                    DashboardChartEntity item,
                    _,
                    ) {
                  return item.averageVoltage;
                },

                color: Colors.green,
              ),
            ],
          ),
        );
      }),
    );
  }
}

///
/// POWER OUTPUT CARD
///
class PowerOutputCard extends GetView<DashboardController> {
  const PowerOutputCard({super.key});

  @override
  Widget build(BuildContext context) {
    return _BaseCard(
      title: "توان تولیدی",
      subtitle: "میانگین توان تولیدی در بازه انتخاب‌شده",
      child: Obx(() {

        final data = controller.chartData;

        if (data.isEmpty) {
          return const _EmptyChart();
        }

        return _ChartWrapper(
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),

            series: <CartesianSeries>[
              LineSeries<DashboardChartEntity, String>(
                dataSource: data,

                xValueMapper: (
                    DashboardChartEntity item,
                    _,
                    ) {
                  return item.date;
                },

                yValueMapper: (
                    DashboardChartEntity item,
                    _,
                    ) {
                  return item.averagePower;
                },

                color: Colors.green,

                markerSettings: const MarkerSettings(
                  isVisible: true,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

///
/// ENERGY STORAGE CARD
///
class EnergyStorageCard extends GetView<DashboardController> {
  const EnergyStorageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return _BaseCard(
      title: "انرژی",
      subtitle: "میانگین انرژی در بازه انتخاب‌شده",
      child: Obx(() {

        final data = controller.chartData;

        if (data.isEmpty) {
          return const _EmptyChart();
        }

        return _ChartWrapper(
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),

            series: <CartesianSeries>[
              ColumnSeries<DashboardChartEntity, String>(
                dataSource: data,

                xValueMapper: (
                    DashboardChartEntity item,
                    _,
                    ) {
                  return item.date;
                },

                yValueMapper: (
                    DashboardChartEntity item,
                    _,
                    ) {
                  return item.averageEnergy;
                },

                color: Colors.green,
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _EmptyChart extends StatelessWidget {
  const _EmptyChart();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'داده‌ای برای نمایش وجود ندارد',
      ),
    );
  }
}

class AnimatedEntry extends StatelessWidget {
  final Widget child;
  final int delay;

  const AnimatedEntry({super.key, required this.child, required this.delay});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 40, end: 0),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutCubic,
      builder: (_, value, __) {
        return Transform.translate(
          offset: Offset(0, value),
          child: Opacity(
            opacity: (40 - value) / 40,
            child: child,
          ),
        );
      },
    );
  }
}

///
/// SOLAR RADIANCE CARD
///

///
/// TABLE
///
class PanelStatusTable extends GetView<DashboardController> {
  const PanelStatusTable({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: context.width,
      child: Card(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Theme(
              data: theme.copyWith(
                checkboxTheme: CheckboxThemeData(
                  fillColor: MaterialStateProperty.resolveWith<Color>(
                        (states) {
                      if (states.contains(MaterialState.selected)) {
                        return Colors.green;
                      }
                      return Colors.grey.shade400;
                    },
                  ),
                ),
              ),
              child: LayoutBuilder(
                builder: (context, constraint) {
                  return Obx((){
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minWidth: constraint.maxWidth),
                        child: DataTable(

                          columnSpacing: 32,
                          headingRowHeight: 48,
                          dataRowHeight: 46,
                          columns: const [

                            DataColumn(
                              label: Text("نام استرینگ", style: TextStyle(fontWeight: FontWeight.bold),),
                            ),

                            DataColumn(
                              label: Text("شناسه استرینگ", style: TextStyle(fontWeight: FontWeight.bold),),
                            ),

                            DataColumn(
                              label: Text("ولتاژ", style: TextStyle(fontWeight: FontWeight.bold),),
                            ),

                            DataColumn(
                              label: Text("جریان", style: TextStyle(fontWeight: FontWeight.bold),),
                            ),

                            DataColumn(
                              label: Text("توان", style: TextStyle(fontWeight: FontWeight.bold),),
                            ),

                            DataColumn(
                              label: Text("انرژی", style: TextStyle(fontWeight: FontWeight.bold),),
                            ),
                          ],
                          rows: controller.strings.map((item) {

                            return DataRow(

                              cells: [

                                DataCell(
                                  Text(item.name),
                                ),

                                DataCell(
                                  Text(
                                    item.stringId.toString(),
                                  ),
                                ),

                                DataCell(
                                  Text(
                                    "${item.voltage} V",
                                  ),
                                ),

                                DataCell(
                                  Text(
                                    "${item.current} A",
                                  ),
                                ),

                                DataCell(
                                  Text(
                                    item.power.toString(),
                                  ),
                                ),

                                DataCell(
                                  Text(
                                    item.energy.toString(),
                                  ),
                                ),

                              ],
                            );

                          }).toList(),
                        ),
                      ),
                    );
                  }
                  );
                }
              ),
            ),
        ),
      ),
    );
  }
}



///
/// BASE CARD UI
///
class _BaseCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;

   _BaseCard({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final _controller = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height / 3,

      child: MouseRegion(
        onHover: (e){
          _controller.isHover.value = true;
        },
        child:  Card(

            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(fontSize: 12)),
                  const SizedBox(height: 12),
                  child,
                ],
              ),
            ),
          ),
        ),
      );
  }
}

///
/// CHART WRAPPER
///
class _ChartWrapper extends StatelessWidget {
  final Widget child;

  const _ChartWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 120, child: child);
  }
}

/// logout:
class UserMenu extends StatelessWidget {

  final String username;
  final VoidCallback onLogout;


  const UserMenu({
    super.key,
    required this.username,
    required this.onLogout,
  });


  void _showLogoutDialog(BuildContext context) {

    showDialog(
      context: context,
      barrierDismissible: false,

      builder: (context) {

        return LogoutConfirmDialog(
          onConfirm: onLogout,
        );

      },
    );

  }



  @override
  Widget build(BuildContext context) {

    return PopupMenuButton<int>(

      tooltip: '',

      offset: const Offset(0, 12),

      elevation: 8,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),


      itemBuilder: (context) {

        return [

          PopupMenuItem(

            enabled: false,

            child: UserProfileItem(
              username: username,
            ),

          ),


          const PopupMenuDivider(),


          PopupMenuItem(

            value: 1,

            child: Directionality(

              textDirection: TextDirection.rtl,

              child: Row(

                children: const [

                  Icon(
                    Icons.logout_rounded,
                    color: Colors.red,
                  ),


                  SizedBox(width: 10),


                  Text(
                    "خروج از حساب کاربری",

                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                ],
              ),
            ),
          ),

        ];

      },


      onSelected: (value){

        if(value == 1){

          _showLogoutDialog(context);

        }

      },


      child: UserProfileButton(
        username: username,
      ),

    );

  }

}

class UserProfileButton extends StatelessWidget {

  final String username;


  const UserProfileButton({
    super.key,
    required this.username,
  });


  @override
  Widget build(BuildContext context) {

    return Container(

      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 9,
      ),


      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius: BorderRadius.circular(30),


        border: Border.all(
          color: Colors.grey.shade300,
        ),

      ),


      child: Row(

        mainAxisSize: MainAxisSize.min,

        children: [


          CircleAvatar(

            radius: 18,

            backgroundColor: Colors.blue.shade50,


            child: Icon(

              Icons.person_outline_rounded,

              color: Colors.blue.shade700,

            ),

          ),



          const SizedBox(width: 10),



          Text(

            username,

            style: const TextStyle(

              fontWeight: FontWeight.w600,

            ),

          ),



          const SizedBox(width: 5),



          const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 22,
          ),


        ],
      ),
    );

  }

}

class UserProfileItem extends StatelessWidget {

  final String username;


  const UserProfileItem({
    super.key,
    required this.username,
  });


  @override
  Widget build(BuildContext context) {

    return Directionality(

      textDirection: TextDirection.rtl,


      child: Row(

        children: [


          CircleAvatar(

            radius: 20,

            backgroundColor: Colors.blue.shade50,


            child: Icon(

              Icons.person,

              color: Colors.blue.shade700,

            ),

          ),



          const SizedBox(width: 12),



          Flexible(

            child: Text(

              username,

              overflow: TextOverflow.ellipsis,


              style: const TextStyle(

                fontWeight: FontWeight.bold,

              ),

            ),
          ),


        ],
      ),
    );

  }

}

class LogoutConfirmDialog extends StatelessWidget {

  final VoidCallback onConfirm;


  const LogoutConfirmDialog({

    super.key,

    required this.onConfirm,

  });



  @override
  Widget build(BuildContext context) {


    final width = MediaQuery.of(context).size.width;


    return Directionality(

      textDirection: TextDirection.rtl,


      child: Dialog(

        shape: RoundedRectangleBorder(

          borderRadius: BorderRadius.circular(22),

        ),


        child: ConstrainedBox(

          constraints: BoxConstraints(

            maxWidth: width > 500 ? 420 : width * .85,

          ),


          child: Padding(

            padding: const EdgeInsets.all(24),


            child: Column(

              mainAxisSize: MainAxisSize.min,


              children: [



                Container(

                  width: 60,

                  height: 60,


                  decoration: BoxDecoration(

                    color: Colors.red.shade50,

                    shape: BoxShape.circle,

                  ),


                  child: Icon(

                    Icons.logout_rounded,

                    size: 32,

                    color: Colors.red.shade600,

                  ),

                ),




                const SizedBox(height: 18),




                const Text(

                  "خروج از حساب کاربری",

                  style: TextStyle(

                    fontSize: 18,

                    fontWeight: FontWeight.bold,

                  ),

                ),




                const SizedBox(height: 12),




                Text(

                  "آیا مطمئن هستید که می‌خواهید از حساب کاربری خود خارج شوید؟",

                  textAlign: TextAlign.center,


                  style: TextStyle(

                    color: Colors.grey.shade700,

                    height: 1.8,

                  ),

                ),




                const SizedBox(height: 25),




                Row(

                  children: [



                    Expanded(

                      child: OutlinedButton(

                        onPressed: (){

                          Navigator.pop(context);

                        },


                        child: const Text(
                          "انصراف",
                        ),

                      ),

                    ),



                    const SizedBox(width: 12),




                    Expanded(

                      child: FilledButton(

                        style: FilledButton.styleFrom(

                          backgroundColor: Colors.red,

                        ),


                        onPressed: (){


                          Navigator.pop(context);


                          onConfirm();


                        },


                        child: const Text(

                          "خروج",

                        ),

                      ),

                    ),


                  ],

                )


              ],

            ),

          ),

        ),

      ),

    );

  }

}

class PanelBackButton extends StatelessWidget {
  const PanelBackButton({super.key, required this.onPressed});

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: CustomAppColors.backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.arrow_back_rounded,
            size: 23,
          ),
        ),
      ),
    );
  }
}