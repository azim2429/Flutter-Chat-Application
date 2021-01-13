import 'package:chatapp/Widget/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat').orderBy('time',descending: true)
            .snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = streamSnapshot.data.docs;
          var currId = FirebaseAuth.instance.currentUser.uid;
          return ListView.builder(
            reverse: true,
            itemCount: streamSnapshot.data.docs.length,
            itemBuilder: (ctx, index) => MessageBubble(documents[index]['text'],documents[index]['userId']==currId,documents[index]['userImage'],key: ValueKey(documents[index].id)),
          );
        });
  }
}
