import 'package:flutter/material.dart';
import 'package:grauation_project_dashboard/core/widgets/custom_app_bar.dart';


import 'ngo_details.dart';
import 'ngo_expansion_tile.dart';

class ManageNgoViewBody extends StatelessWidget {
  const ManageNgoViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppBar(
          title: 'Manage Ngos',
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: const [
                NgoExpansionTile(
                    userName: 'Ngo One',
                    ngoDetails: NgoDetails(
                      ngoId: '1',
                      ngoCode: 'one201',
                      contactNo: '01025457089',
                      email: 'ngoone@gmail.com',
                      address: 'Aswan',
                    )),
                SizedBox(height: 8),
                NgoExpansionTile(
                    userName: 'Ngo Two',
                    ngoDetails: NgoDetails(
                      ngoId: '1',
                      ngoCode: 'one201',
                      contactNo: '01025457089',
                      email: 'ngoone@gmail.com',
                      address: 'Aswan',
                    )),
                SizedBox(height: 8),
                NgoExpansionTile(
                    userName: 'Ngo Two',
                    ngoDetails: NgoDetails(
                      ngoId: '1',
                      ngoCode: 'one201',
                      contactNo: '01025457089',
                      email: 'ngoone@gmail.com',
                      address: 'Aswan',
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
