import 'package:flutter/material.dart';
import 'package:grauation_project_dashboard/core/utils/app_text_styles.dart';

import '../../../../dashboard/views/widgets/member_medicine_details_section.dart';
import 'member_details.dart';

class MemberExpansionTile extends StatelessWidget {
  final String userName;
  final MemberDetails memberDetails;
  final bool blocked;

  const MemberExpansionTile({
    super.key,
    required this.userName,
    required this.memberDetails,
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
            memberDetails,
            MemberMedicineDetailsSection(
              memberId: memberDetails.memberId,
              blocked: blocked,
            ),
          ],
        ),
      ),
    );
  }
}
