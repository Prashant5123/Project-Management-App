import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        shape: BoxShape.rectangle,
        color:
            isCurrentUser
                ? Colors.green
                : const Color.fromARGB(255, 59, 57, 57),
      ),
      child: Text(message, style: TextStyle(color: Colors.white)),
    );
  }
}
