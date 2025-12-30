import 'package:flutter/material.dart';

class PanelOverviewPage extends StatelessWidget {
  PanelOverviewPage({super.key});

  // دیتای تست (40 آیتم)
  final List<PanelItem> panels = List.generate(
    40,
        (index) => PanelItem(
      id: index + 1,
      value: 70 + (index % 10),
      isActive: index % 7 != 0, // چندتا قرمز برای تست
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: 900,
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
              /// Title
              const Text(
                'نمای کلی پنل‌ها',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              /// Grid
              GridView.builder(
                shrinkWrap: true,
                itemCount: panels.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 10,
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
    );
  }
}


class PanelBox extends StatelessWidget {
  final PanelItem item;

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
            item.value.toString(),
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


class PanelItem {
  final int id;
  final int value;
  final bool isActive;

  PanelItem({
    required this.id,
    required this.value,
    required this.isActive,
  });
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

