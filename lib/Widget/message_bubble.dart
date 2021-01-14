import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

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
  bool secure = true;
  String secureMessage = '';

  void main() {
    var plainText = widget.message;

    final key = encrypt.Key.fromLength(32);
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    //final decrypted = encrypter.decrypt(encrypted, iv: iv);

//    print(decrypted);
//    print(encrypted.base16.substring(0,15));
    secureMessage = encrypted.base16.substring(0, 20);
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
                    secure ? secureMessage : widget.message,
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
            onTap: () {
              setState(() {
                //main();
                //print(widget.message);
                secure = !secure;
              });
            },
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
