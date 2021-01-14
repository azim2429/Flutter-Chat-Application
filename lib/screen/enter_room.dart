import 'package:chatapp/screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JoinRoom extends StatelessWidget {
  var roomId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme
          .of(context)
          .primaryColor,
      body: Center(
        child: Container(
          width: 250,
          height: 250,
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Join Room',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    key: ValueKey('roomId'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a valid Room ID';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      roomId = value;
                    },
                    onChanged: (value){
                      roomId = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Room ID',
                    ),
                  ),
                ),
                FlatButton(
                    onPressed: () async {
                      print(roomId);
                      SharedPreferences pref = await SharedPreferences.getInstance();
                      pref.setString('room', roomId);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(),
                        ),
                      );
                    },
                    color: Theme
                        .of(context)
                        .primaryColor,
                    child: Text('Join', style: TextStyle(color: Colors.white),))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
