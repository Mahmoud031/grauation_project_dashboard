import 'package:flutter/material.dart';

import '../../../../dashboard/views/widgets/detail_row.dart';

class NgoDetails extends StatelessWidget {
  final String uId;
  final String email;
  final String phone;
  final String ngoId;
  final String address;

  const NgoDetails({
    super.key,
    required this.uId,
    required this.email,
    required this.phone,
    required this.ngoId,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailRow(label: 'UId', value: uId),
          DetailRow(label: 'Ngo ID', value: ngoId),
          DetailRow(label: 'Contact No', value: phone),
          DetailRow(label: 'E-mail', value: email),
          DetailRow(label: 'Address', value: address),
        ],
      ),
    );
  }
}
