import 'package:chatapp/screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

class JoinRoom extends StatefulWidget {
  @override
  _JoinRoomState createState() => _JoinRoomState();
}

class _JoinRoomState extends State<JoinRoom> {
  final _formKey = GlobalKey<FormState>();

  var roomId;
  int randomRoomID;

  void generateRoomId() {
    Random random = new Random();
    setState(() {
      randomRoomID = random.nextInt(99999);
    });

    print(randomRoomID);
  }

  void submit() async {
    final valid = _formKey.currentState.validate();

    if (valid) {
      _formKey.currentState.save();
      print(roomId);
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('room', roomId);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
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
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      initialValue: randomRoomID.toString(),
                      key: ValueKey('roomId'),
                      validator: (value) {
                        if (value.length < 5 || value.length > 6) {
                          return 'Please enter 5 digit room ID';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        roomId = value;
                      },
                      onChanged: (value) {
                        roomId = value;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: randomRoomID.toString(),
                        hintText: randomRoomID.toString()
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      onPressed: (){
                        generateRoomId();
                      },
                      elevation: 5,
                      child: Text('Generate',style: TextStyle(color: Colors.white),),
                      color: Colors.purpleAccent,
                    ),
                    FlatButton(
                        onPressed: () {
                          submit();
                        },
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          'Join',
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
