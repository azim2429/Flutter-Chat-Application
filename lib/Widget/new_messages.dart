import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';


class NewMessages extends StatefulWidget {
  @override
  _NewMessagesState createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  var _enteredMessage;
  final _controller = new TextEditingController();
  Color button = Color(0xff125589);

  void _sendMessage() async {
    FirebaseAuth auth = await FirebaseAuth.instance;
    SharedPreferences pref = await SharedPreferences.getInstance();
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser.uid)
        .get();
    FocusScope.of(context).unfocus();
    FirebaseFirestore.instance.collection('chat/rooms/'+pref.getString('room')).add({
      'text': _enteredMessage,
      'time': DateTime.now(),
      'userId': auth.currentUser.uid,
      'userImage': userData['image_url'],
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              keyboardType: TextInputType.multiline,
              controller: _controller,
              cursorColor: button,
              decoration: InputDecoration(
                hintText: 'Send Message',
                fillColor: Colors.pink,
                hintStyle: TextStyle(color: button),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    width: 1.5,
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
              icon: Icon(Icons.send,color: button),
              onPressed: _enteredMessage.toString().trim().isEmpty
                  ? null
                  : () {
                      _sendMessage();
                    })
        ],
      ),
    );
  }
}
