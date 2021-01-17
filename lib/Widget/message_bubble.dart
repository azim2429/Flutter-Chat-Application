import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:intl/intl.dart';

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
  Color urMessage = Color(0xffeeeeee);


  void main() {
    var plainText = widget.message;
    final key = encrypt.Key.fromLength(32);
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    //final decrypted = encrypter.decrypt(encrypted, iv: iv);

//    print(decrypted);
//    print(encrypted.base16.substring(0,15));
    secureMessage = encrypted.base16.substring(0, 18);
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
                    widget.isMe ? myMessage : urMessage,
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
                crossAxisAlignment: widget.isMe
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    secure ? secureMessage : widget.message,
                    style: TextStyle(color: widget.isMe?Colors.white:Colors.black, fontSize: 16),
                    textAlign: widget.isMe ? TextAlign.end : TextAlign.start,
                  ),
                  SizedBox(height: 3),
                  Text(widget.time.toString().substring(11, 16),style: TextStyle(color: widget.isMe?Colors.white70:Colors.black45,fontSize: 12),),
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
              backgroundImage: NetworkImage(widget.userImage),
            ),
          ),
        ),
      ],
      overflow: Overflow.visible,
    );
  }
}
