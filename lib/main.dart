import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grauation_project_dashboard/core/helper_functions/on_generate_routes.dart';

import 'features/dashboard/views/dashboard_view.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: DashboardView.routeName,
      onGenerateRoute: onGenerateRoutes,
      debugShowCheckedModeBanner: false,
    );
  }
}
