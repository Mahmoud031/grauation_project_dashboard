import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grauation_project_dashboard/features/dashboard/views/manage_members_view.dart';
import 'package:grauation_project_dashboard/features/dashboard/views/widgets/dashboard_card.dart';

import 'manage_members_view_body.dart';

class DashboardViewBody extends StatelessWidget {
  const DashboardViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 16),
      child: Column(
        children: [
          DashboardCard(
            title: 'Manage Members',
            icon: FontAwesomeIcons.users,
            color: Colors.blue,
            onTap: () {
              Navigator.pushNamed(
                context,
                ManageMembersView.routeName,
              );
            },
          ),
          const SizedBox(height: 16),
          DashboardCard(
            title: 'Manage NGOs',
            icon: FontAwesomeIcons.handshakeAngle,
            color: Colors.green,
            onTap: () {},
          ),
          const SizedBox(height: 16),
          DashboardCard(
            title: 'Manage Approval',
            icon: FontAwesomeIcons.circleCheck,
            color: Colors.orange,
            onTap: () {},
          ),
          const SizedBox(height: 16),
          DashboardCard(
            title: 'Reporting',
            icon: FontAwesomeIcons.chartBar,
            color: Colors.purple,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
