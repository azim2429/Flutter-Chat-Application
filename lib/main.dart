import 'package:chatapp/screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screen/auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Widget home = AuthScreen();
  FirebaseAuth auth = FirebaseAuth.instance;
  if (auth.currentUser != null) {
    home = ChatScreen();
  }

  runApp(
    new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Chat',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: home,
      // home: ChatScreen(),
    ),
  );
}
