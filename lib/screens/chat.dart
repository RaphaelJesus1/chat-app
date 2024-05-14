import 'package:chat_app/utils/firebase.dart';
import 'package:chat_app/widgets/chat/chat_input.dart';
import 'package:chat_app/widgets/chat/chat_messages.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  void _logout() {
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlutterChat'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app_outlined,
                color: Theme.of(context).colorScheme.primary),
            onPressed: _logout,
          )
        ],
      ),
      body: const Column(
          children: [Expanded(child: ChatMessages()), ChatInput()]),
    );
  }
}
