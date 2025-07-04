import 'package:flutter/material.dart';

import 'widgets/medicine_details_view_body.dart';

class MedicineDetailsView extends StatelessWidget {
  final String userId;
  const MedicineDetailsView({super.key, required this.userId});
  static const String routeName = 'medicine_details_view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Medicine Details',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: MedicineDetailsViewBody(userId: userId),
    );
  }
}
