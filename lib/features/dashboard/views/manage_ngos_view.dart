import 'package:flutter/material.dart';

import 'widgets/manage_ngo_view_body.dart';

class ManageNgosView extends StatelessWidget {
  const ManageNgosView({super.key});
  static const String routeName = 'manage_ngos_view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body:ManageNgoViewBody(),
    );
  }
}