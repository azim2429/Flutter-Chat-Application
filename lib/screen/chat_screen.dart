import 'package:chatapp/Widget/messages.dart';
import 'package:chatapp/Widget/new_messages.dart';
import 'package:chatapp/screen/auth_screen.dart';
import 'package:flutter/material.dart';
import 'enter_room.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var roomID;
  Color appBar = Color(0xff125589);

  void logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('token');
    FirebaseAuth.instance.signOut();
    print('logout');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AuthScreen()),
    );
  }

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBar,
        title: Text('Room ID : ' + roomID.toString(),style: TextStyle(color: Colors.white),),
        leading: IconButton(
          onPressed: (){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => JoinRoom()),
            );
          },
            color: Colors.white,
          icon: Icon(Icons.home)

        ),
        centerTitle: true,
        actions: [
          DropdownButton(
            onChanged: (item) {
              if (item == 'logout') {
                logout();
              }
            },
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 25),
                      Text('Logout')
                    ],
                  ),
                ),
                value: 'logout',
              )
            ],
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            NewMessages(),
          ],
        ),
      ),
    );
  }
}
