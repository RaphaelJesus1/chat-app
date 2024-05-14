import 'package:chat_app/utils/firebase.dart';
import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticatedUserId = auth.currentUser!.uid;

    return StreamBuilder(
        stream: database
            .collection("chat")
            .orderBy("createdAt", descending: true)
            .snapshots(),
        builder: (context, chatSnapshots) {
          if (chatSnapshots.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!chatSnapshots.hasData || chatSnapshots.data!.docs.isEmpty) {
            return const Center(child: Text('No messages found.'));
          }

          if (chatSnapshots.hasError) {
            return const Center(child: Text('Something went wrong...'));
          }

          final loadedMessages = chatSnapshots.data!.docs;
          return ListView.builder(
              padding: const EdgeInsets.only(bottom: 40, left: 12, right: 12),
              reverse: true,
              itemCount: loadedMessages.length,
              itemBuilder: (ctx, index) {
                final chatMessage = loadedMessages[index].data();
                final nextChatMessage = index + 1 < loadedMessages.length
                    ? loadedMessages[index + 1].data()
                    : null;

                final isMyMessage =
                    authenticatedUserId == chatMessage["userId"];
                final nextUserIsSame =
                    chatMessage["userId"] == nextChatMessage?["userId"];
                if (nextUserIsSame) {
                  return MessageBubble.next(
                      message: chatMessage["text"], isMe: isMyMessage);
                }
                return MessageBubble.first(
                    userImage: chatMessage["userImage"],
                    username: chatMessage["username"],
                    message: chatMessage["text"],
                    isMe: isMyMessage);
              });
        });
  }
}
