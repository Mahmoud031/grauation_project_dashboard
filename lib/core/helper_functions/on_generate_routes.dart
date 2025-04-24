import 'package:flutter/material.dart';
import 'package:grauation_project_dashboard/features/dashboard/views/dashboard_view.dart';
import 'package:grauation_project_dashboard/features/dashboard/views/manage_members_view.dart';


Route<dynamic> onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case DashboardView.routeName:
      return MaterialPageRoute(
        builder: (context) => const DashboardView(),
      );
      case ManageMembersView.routeName:
      return MaterialPageRoute(
        builder: (context) => const ManageMembersView(),
      );
   
    default:
      return MaterialPageRoute(builder: (_) => const Scaffold());
  }
}
