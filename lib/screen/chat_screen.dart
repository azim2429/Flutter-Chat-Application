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
  Color back = Color(0xffffffff);

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

  void room() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => JoinRoom()),
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
      backgroundColor: back,
      appBar: AppBar(
        elevation: 10,
        backgroundColor: appBar,
        title: Text(
          'Room ID : ' + roomID.toString(),
          style: TextStyle(color: Colors.white),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () {
              setState(() {});
            },
            child: Image(
              image: AssetImage('assest/icon.png'),
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          DropdownButton(
            onChanged: (item) {
              if (item == 'logout') {
                logout();
              }
              if (item == 'room') {
                room();
              }
            },
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            items: [
              DropdownMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.exit_to_app),
                    SizedBox(width: 25),
                    Text('Logout'),
                  ],
                ),
                value: 'logout',
              ),
              DropdownMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.home),
                    SizedBox(width: 25),
                    Text('Room'),
                  ],
                ),
                value: 'room',
              ),
            ],
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
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
