import 'package:flutter/material.dart';
import 'package:grauation_project_dashboard/features/manage_ngo/presentation/views/widgets/ngo_medicine_details_view_body.dart';

class NgoMedicineDetailsView extends StatelessWidget {
  final String ngoUId;
  const NgoMedicineDetailsView({super.key, required this.ngoUId});
  static const String routeName = 'ngo_medicine_details_view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Ngo Medicine Details',
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: NgoMedicineDetailsViewBody(ngoUId: ngoUId));
  }
}
