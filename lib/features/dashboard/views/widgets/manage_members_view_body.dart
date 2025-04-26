import 'package:flutter/material.dart';
import 'package:grauation_project_dashboard/core/widgets/custom_app_bar.dart';
import 'member_details.dart';
import 'member_expansion_tile.dart';

class ManageMembersViewBody extends StatelessWidget {
  const ManageMembersViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppBar(
          title: 'Manage Members',
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: const [
                MemberExpansionTile(
                  userName: 'Member One',
                  memberDetails: MemberDetails(
                    memberId: '1',
                    age: '25',
                    contactNo: '93472001',
                    email: 'memb1@gmail.com',
                    address: 'Aswan',
                    type: 'Indiviudal',
                  ),
                ),
                SizedBox(height: 8),
                MemberExpansionTile(
                  userName: 'Member Two',
                  memberDetails: MemberDetails(
                    memberId: '2',
                    age: '30',
                    contactNo: '93472002',
                    email: 'memb2@gmail.com',
                    address: 'Aswan',
                    type: 'Manufacturer',
                  ),
                ),
                SizedBox(height: 8),
                MemberExpansionTile(
                  userName: 'Member Three',
                  memberDetails: MemberDetails(
                    memberId: '3',
                    age: '21',
                    contactNo: '93472002',
                    email: 'memb3@gmail.com',
                    address: 'Aswan',
                    type: 'Pharmacy',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
