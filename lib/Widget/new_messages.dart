import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessages extends StatefulWidget {
  @override
  _NewMessagesState createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  var _enteredMessage;
  final _controller = new TextEditingController();

  void _sendMessage() async {
    FirebaseAuth auth = await FirebaseAuth.instance;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser.uid)
        .get();
    FocusScope.of(context).unfocus();
    FirebaseFirestore.instance.collection('chat').add({
      'text': _enteredMessage,
      'time': Timestamp.now(),
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
              controller: _controller,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                hintText: 'Send Message',
                //fillColor: Colors.pink,
                hintStyle: TextStyle(color: Colors.black),
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
              icon: Icon(Icons.send,color: Colors.purpleAccent.shade400),
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
