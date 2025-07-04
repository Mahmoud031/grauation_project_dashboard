import 'package:flutter/material.dart';
import 'package:grauation_project_dashboard/features/dashboard/views/dashboard_view.dart';
import 'package:grauation_project_dashboard/features/manage_memebers/presentation/views/manage_members_view.dart';
import 'package:grauation_project_dashboard/features/manage_memebers/presentation/views/medicine_details_view.dart';
import 'package:grauation_project_dashboard/features/manage_ngo/presentation/views/manage_ngos_view.dart';
import 'package:grauation_project_dashboard/features/manage_ngo/presentation/views/ngo_medicine_detalis_view.dart';

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
      case MedicineDetailsView.routeName:
      return MaterialPageRoute(
        builder: (context) => MedicineDetailsView(userId: settings.arguments as String),
      );
      case NgoMedicineDetailsView.routeName:
      return MaterialPageRoute( 
        builder: (context) => NgoMedicineDetailsView(ngoUId: settings.arguments as String),
      );
    case ManageNgosView.routeName:
      return MaterialPageRoute(
        builder: (context) => const ManageNgosView(),
      );

    default:
      return MaterialPageRoute(builder: (_) => const Scaffold());
  }
}
