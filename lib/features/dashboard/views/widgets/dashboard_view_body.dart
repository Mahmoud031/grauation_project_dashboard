import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grauation_project_dashboard/features/manage_memebers/presentation/views/manage_members_view.dart';
import 'package:grauation_project_dashboard/features/dashboard/views/widgets/dashboard_card.dart';

import '../../../manage_ngo/presentation/views/manage_ngos_view.dart';
import '../../../messages/presentation/views/messages_from_donors_view.dart';
import '../../../messages/presentation/views/messages_from_ngos_view.dart';
import '../../../reports/presentation/views/reports_view.dart';

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
              Navigator.pushNamed(context, ManageMembersView.routeName);
            },
          ),
          const SizedBox(height: 16),
          DashboardCard(
            title: 'Manage NGOs',
            icon: FontAwesomeIcons.handshakeAngle,
            color: Colors.green,
            onTap: () {
              Navigator.pushNamed(context, ManageNgosView.routeName);
            },
          ),
          const SizedBox(height: 16),
          DashboardCard(
            title: 'Messages from Ngos',
            icon: FontAwesomeIcons.solidMessage,
            color: Colors.red,
            onTap: () {
              Navigator.pushNamed(context, MessagesFromNgosView.routeName);
            },
          ),
          const SizedBox(height: 16),
          DashboardCard(
            title: 'Messages from donors',
            icon: FontAwesomeIcons.message,
            color: Colors.orange,
            onTap: () {
              Navigator.pushNamed(context, MessagesFromDonorsView.routeName);
            },
          ),
          DashboardCard(
            title: 'Reporting',
            icon: FontAwesomeIcons.chartBar,
            color: Colors.purple,
            onTap: () {
              Navigator.pushNamed(context, ReportsView.routeName);
            },
          ),
        ],
      ),
    );
  }
}
