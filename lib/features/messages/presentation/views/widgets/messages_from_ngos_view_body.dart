import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessagesFromNgosViewBody extends StatelessWidget {
  const MessagesFromNgosViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('ngo_messages').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final docs = snapshot.data?.docs ?? [];
        if (docs.isEmpty) {
          return const Center(child: Text('No messages found.'));
        }
        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final doc = docs[index];
            final data = doc.data() as Map<String, dynamic>;
            final message = data['message'] ?? '';
            final subject = data['subject'] ?? '';
            final userName = data['userName'] ?? '';
            final userId = data['userId'] ?? '';
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text('From: ${userName}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          tooltip: 'Delete message',
                          onPressed: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Delete Message'),
                                content: const Text(
                                    'Are you sure you want to delete this message?'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                    child: const Text('Delete',
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                ],
                              ),
                            );
                            if (confirm == true) {
                              try {
                                await FirebaseFirestore.instance
                                    .collection('ngo_messages')
                                    .doc(doc.id)
                                    .delete();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Message deleted.')),
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Failed to delete: ${e.toString()}')),
                                );
                              }
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text('Subject: ${subject}',
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Text('Message: ${message}'),
                    const SizedBox(height: 16),
                    _ResponseForm(messageId: doc.id),
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

class _ResponseForm extends StatefulWidget {
  final String messageId;
  const _ResponseForm({required this.messageId});

  @override
  State<_ResponseForm> createState() => _ResponseFormState();
}

class _ResponseFormState extends State<_ResponseForm> {
  final _controller = TextEditingController();
  bool _sending = false;
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _sendResponse() async {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      setState(() => _error = 'Response cannot be empty.');
      return;
    }
    setState(() {
      _sending = true;
      _error = null;
    });
    try {
      await FirebaseFirestore.instance
          .collection('ngo_messages')
          .doc(widget.messageId)
          .collection('responses')
          .add({
        'response': text,
        'timestamp': FieldValue.serverTimestamp(),
      });
      _controller.clear();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Response sent!')),
      );
    } catch (e) {
      setState(() => _error = 'Failed to send response: ${e.toString()}');
    } finally {
      setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: 'Your response',
            errorText: _error,
            border: const OutlineInputBorder(),
          ),
          minLines: 1,
          maxLines: 3,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            ElevatedButton(
              onPressed: _sending ? null : _sendResponse,
              child: _sending
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('Send Response'),
            ),
          ],
        ),
      ],
    );
  }
}
