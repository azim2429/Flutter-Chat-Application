import 'dart:io';

import 'package:chatapp/Widget/auth_form.dart';
import 'package:chatapp/screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var isLoading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  var message;

  void _submitAuthForm(String email, String pass, String username, File image,
      bool isLogin, BuildContext ctx) async {
    UserCredential userCredential;
    try {
      setState(() {
        isLoading = true;
      });
      if (isLogin) {
        userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: pass);

        if (auth.currentUser != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatScreen()),
          );
        }
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: pass,
        );

      final ref =  FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child(_auth.currentUser.uid + '.jpg');
         
      await ref.putFile(image);

      final url = await ref.getDownloadURL();
      
        if (auth.currentUser != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ChatScreen()),
          );
        }
        print("Hello" + '$userCredential');
        FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user.uid)
            .set({
          'username': username,
          'email': email,
          'image_url':url
        });
      }
    } on PlatformException catch (err) {
      message = 'Please check again!';

      if (err.message != null) {
        message = err.message;
      }

      setState(() {
        isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthWidget(_submitAuthForm, isLoading),
    );
  }
}
