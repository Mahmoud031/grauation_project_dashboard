import 'package:flutter/material.dart';
import 'package:grauation_project_dashboard/core/helper_functions/on_generate_routes.dart';

import 'features/dashboard/views/dashboard_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Judson',
      ),
      initialRoute: DashboardView.routeName,
      onGenerateRoute: onGenerateRoutes,
      debugShowCheckedModeBanner: false,
    );
  }
}
