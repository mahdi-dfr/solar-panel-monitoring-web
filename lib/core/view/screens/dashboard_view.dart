import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solar_web/constants/constant.dart';
import 'package:solar_web/core/contrroller/dashboard_controller.dart';
import 'package:solar_web/core/view/widgets/widgets.dart';

import '../../../constants/app_colors.dart';
import 'hitmap_screen.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return Scaffold(
          backgroundColor: CustomAppColors.backgroundColor,
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AppConstants.logo, width: context.width / 14,),
                          SizedBox(width: 24,),
                          Column(
                            children: [
                              const Text("نمای کلی", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              const Text("خلاصه وضعیت سیستم"),
                            ],
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.to(PanelOverviewPage());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomAppColors.secondaryColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          elevation: 6,
                        ),
                        child: Text('هیت مپ', style: TextStyle(color: CustomAppColors.backgroundColor),),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  TopCards(),
                  const SizedBox(height: 32),

                  /// TABLE
                  const PanelStatusTable(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class TopCards extends StatelessWidget {
  const TopCards({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return LayoutBuilder(
      builder: (_, __) {
        double cardWidth;

        if (width >= 1200) {
          cardWidth = (width - 96) / 4; // 4 کارت کنار هم
        } else if (width >= 900) {
          cardWidth = (width - 64) / 2; // 2 کارت
        } else {
          cardWidth = width; // موبایل
        }
        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            SizedBox(
              width: cardWidth,
              child: const AnimatedEntry(delay: 0, child: SolarRadianceCard()),
            ),
            SizedBox(
              width: cardWidth,
              child: const AnimatedEntry(delay: 120, child: PowerOutputCard()),
            ),
            SizedBox(
              width: cardWidth,
              child: const AnimatedEntry(delay: 240, child: EnergyStorageCard()),
            ),
            SizedBox(
              width: cardWidth,
              child: const AnimatedEntry(delay: 360, child: LatestEventsCard()),
            ),
          ],
        );
      },
    );
  }
}
