import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solar_web/constants/app_colors.dart';
import 'package:solar_web/constants/constant.dart';
import 'package:solar_web/features/dashboard/domain/entities/live_string_entity.dart';
import 'package:solar_web/features/dashboard/presentation/controller/dashboard_controller.dart';

import '../../../../constants/route_helper.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solar_web/constants/app_colors.dart';
import 'package:solar_web/constants/constant.dart';
import 'package:solar_web/features/dashboard/domain/entities/live_string_entity.dart';
import 'package:solar_web/features/dashboard/presentation/controller/dashboard_controller.dart';

class PanelOverviewPage extends StatelessWidget {
  PanelOverviewPage({super.key});

  final DashboardController controller =
  Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomAppColors.backgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding =
            constraints.maxWidth < 600 ? 12.0 : 24.0;

            final verticalPadding =
            constraints.maxWidth < 600 ? 12.0 : 24.0;

            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: Column(
                children: [
                  PanelOverviewHeader(
                    controller: controller,
                  ),

                  const SizedBox(height: 16),

                  Expanded(
                    child: PanelOverviewContent(
                      controller: controller,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}



class PanelOverviewHeader extends StatelessWidget {
  final DashboardController controller;

  const PanelOverviewHeader({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 700;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(
            isMobile ? 14 : 20,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: isMobile
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PanelOverviewTopRow(
                isMobile: true,
              ),

              const SizedBox(height: 16),

              PanelStatistics(
                controller: controller,
              ),
            ],
          )
              : Row(
            children: [
              Image.asset(AppConstants.logo, width: context.width / 14),

              const SizedBox(width: 24),

              const Expanded(
                child: PanelOverviewTitle(),
              ),

              PanelStatistics(
                controller: controller,
              ),
            ],
          ),
        );
      },
    );
  }
}

class PanelOverviewTitle extends StatelessWidget {
  const PanelOverviewTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'نمای کلی استرینگ‌ها',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: 4),

        Text(
          'وضعیت لحظه‌ای استرینگ‌های پروژه',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class PanelBackButton extends StatelessWidget {
  const PanelBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          Get.toNamed(RouteHelper.dashboard);
        },
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

class PanelStatistics extends StatelessWidget {
  final DashboardController controller;

  const PanelStatistics({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
          () {
        final total = controller.strings.length;

        final active = controller.strings
            .where(
              (string) =>
          string.voltage >=
              AppConstants.minimumStringVoltage,
        )
            .length;

        final inactive = total - active;

        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            PanelStatItem(
              title: 'کل',
              value: total,
              color: Colors.blue,
            ),

            PanelStatItem(
              title: 'فعال',
              value: active,
              color: Colors.green,
            ),

            PanelStatItem(
              title: 'غیرفعال',
              value: inactive,
              color: Colors.red,
            ),
          ],
        );
      },
    );
  }
}

class PanelStatItem extends StatelessWidget {
  final String title;
  final int value;
  final Color color;

  const PanelStatItem({
    super.key,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),

          const SizedBox(width: 7),

          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),

          const SizedBox(width: 5),

          Text(
            value.toString(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class PanelOverviewContent extends StatelessWidget {
  final DashboardController controller;

  const PanelOverviewContent({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const PanelLegend(),

        const SizedBox(height: 16),

        Expanded(
          child: PanelGrid(
            controller: controller,
          ),
        ),
      ],
    );
  }
}

class PanelLegend extends StatelessWidget {
  const PanelLegend({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Wrap(
        spacing: 24,
        runSpacing: 8,
        children: [
          LegendItem(
            color: Colors.green,
            text: 'استرینگ فعال',
          ),

          LegendItem(
            color: Colors.red,
            text: 'استرینگ غیرفعال',
          ),
        ],
      ),
    );
  }
}

class PanelGrid extends StatelessWidget {
  final DashboardController controller;

  const PanelGrid({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
          () {
        if (controller.isLoading.value) {
          return const PanelLoadingView();
        }

        if (controller.strings.isEmpty) {
          return const PanelEmptyView();
        }

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
              ),
            ],
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return GridView.builder(
                itemCount: controller.strings.length,
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _getCrossAxisCount(
                    constraints.maxWidth,
                  ),
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  return StringBox(
                    string: controller.strings[index],
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  int _getCrossAxisCount(double width) {
    if (width >= 1400) {
      return 12;
    }

    if (width >= 1100) {
      return 10;
    }

    if (width >= 850) {
      return 8;
    }

    if (width >= 600) {
      return 6;
    }

    if (width >= 400) {
      return 4;
    }

    return 3;
  }
}

class StringBox extends StatelessWidget {
  final LiveStringEntity string;

  const StringBox({
    super.key,
    required this.string,
  });

  @override
  Widget build(BuildContext context) {
    final isActive =
        string.voltage >=
            AppConstants.minimumStringVoltage;

    return Container(
      decoration: BoxDecoration(
        color: isActive
            ? Colors.green
            : Colors.red,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 4,
            ),
            child: Text(
              string.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          const SizedBox(height: 5),

          Text(
            '${string.voltage} V',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
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
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),

        const SizedBox(width: 8),

        Text(
          text,
          style: const TextStyle(
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

class PanelLoadingView extends StatelessWidget {
  const PanelLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class PanelEmptyView extends StatelessWidget {
  const PanelEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.solar_power_outlined,
            size: 64,
            color: Colors.grey,
          ),

          SizedBox(height: 16),

          Text(
            'استرینگی برای نمایش وجود ندارد',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class PanelOverviewTopRow extends StatelessWidget {
  final bool isMobile;

  const PanelOverviewTopRow({
    super.key,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const PanelBackButton(),

        const SizedBox(width: 12),

        const Expanded(
          child: PanelOverviewTitle(),
        ),
      ],
    );
  }
}