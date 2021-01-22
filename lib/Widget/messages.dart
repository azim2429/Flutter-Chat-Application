import 'package:chatapp/Widget/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  var roomID;

  void getRoomID() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      roomID = pref.getString('room');
    });
    print(roomID);
  }

  @override
  void initState() {
    getRoomID();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat/rooms/' + roomID.toString())
            .orderBy('time', descending: true)
            .snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = streamSnapshot.data.docs;
          var currId = FirebaseAuth.instance.currentUser.uid;
          return documents != null
              ? ListView.builder(
                  reverse: true,
                  itemCount: streamSnapshot.data.docs.length,
                  itemBuilder: (ctx, index) => MessageBubble(
                      documents[index]['text'],
                      documents[index]['userId'] == currId,
                      documents[index]['userImage'],
                      documents[index]['time'].toDate(),
                      key: ValueKey(documents[index].id)))
              : Center(child: Text('No Messages in this room'));
        });
  }
}
