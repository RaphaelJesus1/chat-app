import 'package:chat_app/utils/firebase.dart';
import 'package:chat_app/widgets/chat/chat_input.dart';
import 'package:chat_app/widgets/chat/chat_messages.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void _logout() {
    auth.signOut();
  }

  void setupPushNotifications() async {
    await message.requestPermission();
    message.subscribeToTopic("chat");
  }

  @override
  void initState() {
    super.initState();
    setupPushNotifications();
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
