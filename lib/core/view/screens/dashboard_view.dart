import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solar_web/core/contrroller/dashboard_controller.dart';
import 'package:solar_web/core/view/widgets/widgets.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DashboardController());

    return Scaffold(
      backgroundColor: const Color(0xfff5f6f8),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "نمای کلی",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text("خلاصه وضعیت سیستم"),
              const SizedBox(height: 24),

              /// TOP CARDS
              Row(
                children: const [
                  Expanded(child: AnimatedEntry(delay: 0, child: SolarRadianceCard())),
                  SizedBox(width: 16),
                  Expanded(child: AnimatedEntry(delay: 120, child: PowerOutputCard())),
                  SizedBox(width: 16),
                  Expanded(child: AnimatedEntry(delay: 240, child: EnergyStorageCard())),
                  SizedBox(width: 16),
                  Expanded(child: AnimatedEntry(delay: 360, child: LatestEventsCard())),
                ],
              ),

              const SizedBox(height: 32),

              /// TABLE
              const PanelStatusTable(),
            ],
          ),
        ),
      ),
    );
  }
}
