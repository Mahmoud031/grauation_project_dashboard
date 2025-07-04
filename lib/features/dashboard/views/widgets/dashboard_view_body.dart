import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grauation_project_dashboard/features/manage_memebers/presentation/views/manage_members_view.dart';
import 'package:grauation_project_dashboard/features/dashboard/views/widgets/dashboard_card.dart';

import '../../../manage_ngo/presentation/views/manage_ngos_view.dart';

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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ManageMembersView(),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          DashboardCard(
            title: 'Manage NGOs',
            icon: FontAwesomeIcons.handshakeAngle,
            color: Colors.green,
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ManageNgosView(),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          DashboardCard(
            title: 'Messages from Ngos',
            icon: FontAwesomeIcons.solidMessage,
            color: Colors.red,
            onTap: () {},
          ),
          const SizedBox(height: 16),
          DashboardCard(
            title: 'Messages from donors',
            icon: FontAwesomeIcons.message,
            color: Colors.orange,
            onTap: () {},
          ),
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
