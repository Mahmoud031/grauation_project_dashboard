import 'package:flutter/material.dart';
import 'package:grauation_project_dashboard/core/utils/app_text_styles.dart';
import 'ngo_details.dart';
import 'ngo_medicine_details_section.dart';

class NgoExpansionTile extends StatelessWidget {
  final String userName;
  final NgoDetails ngoDetails;
  final bool blocked;

  const NgoExpansionTile({
    super.key,
    required this.userName,
    required this.ngoDetails,
    required this.blocked,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ExpansionTile(
          title: Text(userName,
              style: TextStyles.textstyle25.copyWith(
                color: const Color(0xFF071A26),
              )),
          children: [
            ngoDetails,
            NgoMedicineDetailsSection(
              ngoId: ngoDetails.uId,
              blocked: blocked,
            ),
          ],
        ),
      ),
    );
  }
}
