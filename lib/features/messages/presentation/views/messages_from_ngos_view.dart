import 'package:flutter/material.dart';

import 'widgets/messages_from_ngos_view_body.dart';

class MessagesFromNgosView extends StatelessWidget {
  const MessagesFromNgosView({super.key});
  static const String routeName = 'messages_from_ngos_view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages from NGOs'),
      ),
      body: MessagesFromNgosViewBody(),
    );
  }
}