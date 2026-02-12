import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solar_web/features/dashboard/domain/entities/project_entity.dart';

import '../../../../constants/app_colors.dart';
import '../controller/project_controller.dart';

// ---------------- VIEW ----------------
class ProjectsListPage extends GetView<ProjectsController> {
  const ProjectsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: CustomAppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width > 1200
                ? 80
                : width > 800
                ? 40
                : 16,
            vertical: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _HeaderSection(),
              const SizedBox(height: 24),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth > 1000) {
                      return _GridProjectsView(columns: 3);
                    } else if (constraints.maxWidth > 700) {
                      return _GridProjectsView(columns: 2);
                    } else {
                      return const _ListProjectsView();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------- HEADER ----------------
class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'پروژه ها',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'پروژه مورد نظر خود را انتخاب کنید',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}

// ---------------- GRID VIEW (WEB/TABLET) ----------------
class _GridProjectsView extends GetView<ProjectsController> {
  final int columns;

  const _GridProjectsView({required this.columns});

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => GridView.builder(
        itemCount: controller.projects.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.8,
        ),
        itemBuilder: (context, index) {
          final project = controller.projects[index];
          return _ProjectCard(project: project);
        },
      ),
    );
  }
}

// ---------------- LIST VIEW (MOBILE) ----------------
class _ListProjectsView extends GetView<ProjectsController> {
  const _ListProjectsView();

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => ListView.separated(
        itemCount: controller.projects.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final project = controller.projects[index];
          return _ProjectCard(project: project);
        },
      ),
    );
  }
}

// ---------------- PROJECT CARD ----------------
class _ProjectCard extends GetView<ProjectsController> {
  final ProjectEntity project;

  const _ProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => controller.getProjects(),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            )
          ],
          border: Border.all(
            color: CustomAppColors.secondaryColor.withOpacity(0.08),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: CustomAppColors.secondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.solar_power,
                    color: CustomAppColors.secondaryColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    project.projectName ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 18),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    project.projectAddress ?? '',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
