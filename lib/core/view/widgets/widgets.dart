import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solar_web/core/contrroller/dashboard_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SolarRadianceCard extends GetView<DashboardController> {
  const SolarRadianceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return _BaseCard(
      title: "تابش خورشیدی",
      subtitle: "میزان تابش خورشید در هر پنل",
      child: Obx(() {
        final p = controller.selectedPanel;
        return _ChartWrapper(
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            series: <CartesianSeries>[
              ColumnSeries<double, String>(
                dataSource: [p.radiance],
                xValueMapper: (_, __) => "Panel ${p.id}",
                yValueMapper: (v, _) => v,
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
      subtitle: "توان خروجی اینورتر",
      child: Obx(() {
        final p = controller.selectedPanel;
        return _ChartWrapper(
          child: SfCartesianChart(
            primaryXAxis: NumericAxis(),
            series: <CartesianSeries>[
              LineSeries<double, double>(
                dataSource: [p.current, p.current * 0.8, p.current * 1.1],
                xValueMapper: (v, i) => i.toDouble(),
                yValueMapper: (v, _) => v,
                color: Colors.green,
                markerSettings: const MarkerSettings(isVisible: true),
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
      title: "انرژی ذخیره‌شده",
      subtitle: "میزان انرژی ذخیره‌شده در باتری",
      child: Obx(() {
        final p = controller.selectedPanel;
        return _ChartWrapper(
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            series: <CartesianSeries>[
              ColumnSeries<double, String>(
                dataSource: [p.voltage],
                xValueMapper: (_, __) => "Battery",
                yValueMapper: (v, _) => v,
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
/// EVENTS CARD
///
class LatestEventsCard extends StatelessWidget {
  const LatestEventsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return _BaseCard(
      title: "آخرین رویدادها",
      subtitle: "آخرین رویدادهای مربوط به سیستم",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("• باتری شماره ۲ کاملاً شارژ شده است", style: TextStyle(color: Colors.green)),
          SizedBox(height: 8),
          Text("• ورود از دستگاه جدید انجام شد"),
          SizedBox(height: 8),
          Text("• سطح شارژ باتری شماره ۳ پایین است", style: TextStyle(color: Colors.red)),
        ],
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
    return SizedBox(
      width: context.width,
      child: Card(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Obx(() {
            return DataTable(
              columns: const [
                DataColumn(label: Text("پنل")),
                DataColumn(label: Text("تابش خورشیدی")),
                DataColumn(label: Text("ولتاژ")),
                DataColumn(label: Text("جریان")),
              ],
              rows: controller.panels.map((panel) {
                return DataRow(
                  selected: controller.selectedPanelId.value == panel.id,
                  onSelectChanged: (_) => controller.selectPanel(panel.id),
                  cells: [
                    DataCell(Text(panel.id.toString())),
                    DataCell(Text("${panel.radiance} kW/m²")),
                    DataCell(Text("${panel.voltage} V")),
                    DataCell(Text("${panel.current} A")),
                  ],
                );
              }).toList(),
            );
          }),
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

  const _BaseCard({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height / 3,

      child: Card(
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
