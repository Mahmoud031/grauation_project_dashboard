import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MedicineDetailsViewBody extends StatelessWidget {
  final String userId;
  const MedicineDetailsViewBody({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection('medicine')
          .where('userId', isEqualTo: userId)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: \\${snapshot.error}'));
        }
        final docs = snapshot.data?.docs ?? [];
        if (docs.isEmpty) {
          return const Center(child: Text('No medicines found for this user.'));
        }
        String clean(dynamic value) {
          if (value == null) return 'N/A';
          final str = value.toString();
          return str.startsWith('\\') ? str.substring(1) : str;
        }

        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final data = docs[index].data() as Map<String, dynamic>;
            // Fix: Check for both 'expireDate' and 'expiryDate'
            String expiry = '';
            if (data['expireDate'] != null &&
                data['expireDate'].toString().trim().isNotEmpty) {
              expiry = clean(data['expireDate']);
            } else if (data['expiryDate'] != null &&
                data['expiryDate'].toString().trim().isNotEmpty) {
              expiry = clean(data['expiryDate']);
            } else {
              expiry = 'N/A';
            }
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (data['imageUrl'] != null &&
                        data['imageUrl'].toString().isNotEmpty)
                      Center(
                        child: Image.network(
                          data['imageUrl'],
                          height: 120,
                          fit: BoxFit.contain,
                        ),
                      ),
                    const SizedBox(height: 8),
                    Text('Name: ${clean(data['medicineName'])}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 4),
                    Text('NGO: ${clean(data['ngoName'])}'),
                    Text('Purchased Date: ${clean(data['purchasedDate'])}'),
                    Text('Received Date: ${clean(data['receivedDate'])}'),
                    Text('Status: ${clean(data['status'])}'),
                    Text('Tablet Count: ${clean(data['tabletCount'])}'),
                    Text('Expire Date: $expiry'),
                    if (data['rejectionMessage'] != null)
                      Text(
                          'Rejection Message: ${clean(data['rejectionMessage'])}'),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
