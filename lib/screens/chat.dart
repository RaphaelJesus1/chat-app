import 'package:chat_app/widgets/chat_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'login.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void _logout() {
      // Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
      //   return const LoginScreen();
      // }));
    }

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
      body: const Stack(children: [
        Center(
          child: Text('No messages found.'),
        ),
        Positioned(bottom: 0, child: ChatInput())
      ]),
    );
  }
}
