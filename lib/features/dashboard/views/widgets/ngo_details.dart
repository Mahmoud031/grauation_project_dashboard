import 'package:flutter/material.dart';

import 'detail_row.dart';

class NgoDetails extends StatelessWidget {
  final String ngoId;
  final String ngoCode;
  final String contactNo;
  final String email;
  final String address;

  const NgoDetails({
    super.key,
    required this.ngoId,
    required this.ngoCode,
    required this.contactNo,
    required this.email,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailRow(label: 'Ngo ID', value: ngoId),
          DetailRow(label: 'Ngo Code', value: ngoCode),
          DetailRow(label: 'Contact No', value: contactNo),
          DetailRow(label: 'E-mail', value: email),
          DetailRow(label: 'Address', value: address),
        ],
      ),
    );
  }
}
