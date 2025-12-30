import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solar_web/constants/app_colors.dart';

import '../../model/hitmap_model.dart';

class PanelOverviewPage extends StatelessWidget {
  PanelOverviewPage({super.key});

  final List<PanelHitMapItem> panels = List.generate(
    40,
        (index) => PanelHitMapItem(
      id: index + 1,
      voltage: 'v ${70 + (index % 10)}',
      isActive: index % 7 != 0, // چندتا قرمز برای تست
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomAppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              const Text(
                'نمای کلی پنل‌ها',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)
              ),
              const SizedBox(height: 32),
              Center(
                child: Container(
                  width: context.width,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xfff7f7f7),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [


                      /// Grid
                      GridView.builder(
                        shrinkWrap: true,
                        itemCount: panels.length,
                        gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: context.width > 900 ? 10 : 5,
                          crossAxisSpacing: 6,
                          mainAxisSpacing: 6,
                          childAspectRatio: 1,
                        ),
                        itemBuilder: (context, index) {
                          return PanelBox(item: panels[index]);
                        },
                      ),

                      const SizedBox(height: 20),

                      /// Legend
                      Row(
                        children: const [
                          LegendItem(
                            color: Colors.green,
                            text: 'پنل فعال',
                          ),
                          SizedBox(width: 20),
                          LegendItem(
                            color: Colors.red,
                            text: 'پنل غیرفعال',
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class PanelBox extends StatelessWidget {
  final PanelHitMapItem item;

  const PanelBox({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: item.isActive ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item.id.toString(),
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item.voltage.toString(),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}




class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const LegendItem({
    super.key,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 6),
        Text(text),
      ],
    );
  }
}

