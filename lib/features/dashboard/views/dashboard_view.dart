import 'package:flutter/material.dart';
import 'package:grauation_project_dashboard/core/utils/app_text_styles.dart';

import 'widgets/dashboard_view_body.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});
  static const String routeName = 'dashboard';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Dashboard',
            style: TextStyles.textstyle30,
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFF071A26),
        ),
        body: DashboardViewBody(),
      ),
    );
  }
}
