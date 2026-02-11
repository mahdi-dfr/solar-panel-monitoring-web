import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solar_web/constants/constant.dart';

import '../../../../constants/app_colors.dart';
import '../../../hitmap/view/screens/hitmap_screen.dart';
import '../controller/dashboard_controller.dart';
import '../widgets/widgets.dart';

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
                          Image.asset(AppConstants.logo, width: context.width / 14),
                          SizedBox(width: 24),
                          Column(
                            children: [
                              const Text(
                                "نمای کلی",
                                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                              ),
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
                        child: Text('هیت مپ', style: TextStyle(color: CustomAppColors.backgroundColor)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  const SizedBox(height: 32),
                  const WeatherOverviewCard(),
                  const SizedBox(height: 48),
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

class WeatherOverviewCard extends GetView<DashboardController> {
  const WeatherOverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            CustomAppColors.secondaryColor.withOpacity(0.8),
            CustomAppColors.secondaryColor.withOpacity(0.9),
          ],
        ),
        boxShadow: [
          BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.1), offset: const Offset(0, 8)),
        ],
      ),
      child: Obx(() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// TEXT
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "وضعیت آب‌وهوا",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 6),
                Text("داده‌های لحظه‌ای محیط", style: TextStyle(color: Colors.white70)),
              ],
            ),

            /// VALUES
            Row(
              children: [
                _WeatherValue(
                  icon: Icons.thermostat,
                  value: "${controller.temperature.value}°C",
                  label: "دما",
                ),
                const SizedBox(width: 32),
                _WeatherValue(icon: Icons.water_drop, value: "${controller.humidity.value}%", label: "رطوبت"),
              ],
            ),
          ],
        );
      }),
    );
  }
}

class _WeatherValue extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _WeatherValue({required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 40, color: Colors.white),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text(label, style: const TextStyle(color: Colors.white70)),
          ],
        ),
      ],
    );
  }
}
