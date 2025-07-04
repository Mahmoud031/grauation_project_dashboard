import 'package:flutter/material.dart';
import 'package:grauation_project_dashboard/features/messages/presentation/views/widgets/messages_from_donors_view_body.dart';

class MessagesFromDonorsView extends StatelessWidget {
  const MessagesFromDonorsView({super.key});
  static const String routeName = 'messages_from_donors_view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Messages from Donors',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: MessagesFromDonorsViewBody());
  }
}