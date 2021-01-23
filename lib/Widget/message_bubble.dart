import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class MessageBubble extends StatefulWidget {
  MessageBubble(this.message, this.isMe, this.userImage, this.time, {this.key});

  final String message;
  final bool isMe;
  final Key key;
  final String userImage;
  final DateTime time;

  @override
  _MessageBubbleState createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  bool secure = true;
  String secureMessage = '';
  Color myMessage = Color(0xff125589);
  Color urMessage = Color(0xffffffff);

  void main() {
    var plainText = widget.message;
    final key = encrypt.Key.fromLength(32);
    final iv = encrypt.IV.fromLength(16);
    final encrypting =
        encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.ctr));
    final encrypted = encrypting.encrypt(plainText, iv: iv);
    secureMessage = encrypted.base16.substring(0, 17);
  }

  @override
  void initState() {
    main();
    super.initState();
  }

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
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 4,
                  ),
                ],
                color: widget.isMe ? myMessage : urMessage,
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
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              margin: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Column(
                crossAxisAlignment: widget.isMe
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    secure ? secureMessage : widget.message,
                    style: TextStyle(
                        color: widget.isMe ? Colors.white : myMessage,
                        fontSize: 16),
                    textAlign: widget.isMe ? TextAlign.end : TextAlign.start,
                  ),
                  SizedBox(height: 2.5),
                  Text(
                    widget.time.toString().substring(11, 16),
                    style: TextStyle(
                        color: widget.isMe ? Colors.white70 : Colors.black45,
                        fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 17,
          left: widget.isMe ? null : 200,
          right: widget.isMe ? 200 : null,
          child: GestureDetector(
            onTap: () {
              setState(() {
                //main();
                //print(widget.message);
                secure = !secure;
              });
            },
            child: CircleAvatar(
              backgroundImage: widget.userImage != null
                  ? NetworkImage(widget.userImage)
                  : NetworkImage(
                      'https://cdn4.iconfinder.com/data/icons/avatars-xmas-giveaway/128/boy_male_avatar_portrait-512.png'),
            ),
          ),
        ),
      ],
      overflow: Overflow.visible,
    );
  }
}
