import 'package:flutter/material.dart';
import 'package:grauation_project_dashboard/core/widgets/custom_side_bar.dart';

import 'widgets/manage_members_view_body.dart';

class ManageMembersView extends StatelessWidget {
  const ManageMembersView({super.key});
  static const String routeName = 'manage_members_view';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CustomSideBar(),
        body: ManageMembersViewBody(),
      ),
    );
  }
}
