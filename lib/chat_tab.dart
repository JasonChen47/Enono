import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChatTab extends StatefulWidget {
  static const title = 'Chat';
  static const androidIcon = Icon(Icons.chat_bubble);
  static const iosIcon = Icon(CupertinoIcons.chat_bubble);

  @override
  State<ChatTab> createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  @override
  Widget build(context) {
    return Center(
      child: Container(
        child: Text('Chat Page'),
      ),
    );
  }
}
