import 'package:flutter/material.dart';
import 'package:grauation_project_dashboard/core/widgets/custom_app_bar.dart';

class ManageMembersViewBody extends StatelessWidget {
  const ManageMembersViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          title: 'Manage Members',
        ),
      ],
    );
  }
}
