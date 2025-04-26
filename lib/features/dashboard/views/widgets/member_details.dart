import 'package:flutter/material.dart';
import 'detail_row.dart';


class MemberDetails extends StatelessWidget {
  final String memberId;
  final String age;
  final String contactNo;
  final String email;
  final String address;
  final String type;

  const MemberDetails({
    super.key,
    required this.memberId,
    required this.age,
    required this.contactNo,
    required this.email,
    required this.address,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailRow(label: 'Member ID', value: memberId),
          DetailRow(label: 'Age', value: age),
          DetailRow(label: 'Contact No', value: contactNo),
          DetailRow(label: 'E-mail ID', value: email),
          DetailRow(label: 'Address', value: address),
          DetailRow(label: 'Type', value: type),
        ],
      ),
    );
  }
}