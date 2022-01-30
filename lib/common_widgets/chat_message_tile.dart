import 'package:flutter/material.dart';

class ChatMessageTile extends StatelessWidget {
  final String messageText;

  final bool sendByMe;

  const ChatMessageTile(
      {Key? key, required this.sendByMe, required this.messageText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                bottomRight: sendByMe
                    ? const Radius.circular(0)
                    : const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft: sendByMe
                    ? const Radius.circular(16)
                    : const Radius.circular(0),
              ),
              color: sendByMe
                  ? Theme.of(context).primaryColor
                  : Colors.blueGrey.withOpacity(0.8),
            ),
            padding: const EdgeInsets.all(16),
            child: Text(
              messageText,
              style: const TextStyle(color: Colors.white),
            )),
      ],
    );
  }
}
