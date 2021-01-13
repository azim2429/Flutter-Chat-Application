import 'package:flutter/material.dart';

class MessageBubble extends StatefulWidget {
  MessageBubble(this.message, this.isMe, this.userImage, {this.key});

  final String message;
  final bool isMe;
  final Key key;
  final String userImage;

  @override
  _MessageBubbleState createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  bool secure = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color:
                    widget.isMe ? Colors.pink.shade200 : Colors.purple.shade200,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft:
                      !widget.isMe ? Radius.circular(0) : Radius.circular(12),
                  bottomRight:
                      widget.isMe ? Radius.circular(0) : Radius.circular(12),
                ),
              ),
              width: 190,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
              margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Column(
                //mainAxisAlignment: isMe?MainAxisAlignment.end:MainAxisAlignment.start,
                children: [
                  Text(
                    widget.message,
                    style: TextStyle(color: Colors.white),
                    textAlign: widget.isMe ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: -5,
          left: widget.isMe ? null : 180,
          right: widget.isMe ? 180 : null,
          child: GestureDetector(
            child: CircleAvatar(
              backgroundImage: NetworkImage(widget.userImage),
            ),
          ),
        ),
      ],
      overflow: Overflow.visible,
    );
  }
}
