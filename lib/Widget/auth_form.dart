import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthWidget extends StatefulWidget {
  AuthWidget(this.submitFn, this.isloading);

  final bool isloading;
  final void Function(String email, String pass, String username,File image, bool isLogin,
      BuildContext ctx) submitFn;

  @override
  _AuthWidgetState createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  final _formKey = GlobalKey<FormState>();
  String _userEmail;
  String _userName;
  String _userPass;
  var _isLogin = true;
  final picker = ImagePicker();
  File _image;

  void _pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera,imageQuality: 50,maxWidth: 150);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _submit() {
    final valid = _formKey.currentState.validate();

    if (_image == null && !_isLogin) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Please pick an image'),backgroundColor: Colors.red,));
      return;
    }

    if (valid) {
      _formKey.currentState.save();
      FocusScope.of(context).unfocus();
      widget.submitFn(
          _userEmail.trim(), _userPass.trim(), _userName, _image,_isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (!_isLogin)
                    CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          _image != null ? FileImage(_image) : null,
                    ),
                  if (!_isLogin)
                    FlatButton.icon(
                        textColor: Colors.pink,
                        icon: Icon(Icons.image),
                        label: Text('Add Image'),
                        onPressed: () {
                          _pickImage();
                        }),
                  TextFormField(
                    key: ValueKey('email'),
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid statement';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userEmail = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email address',
                    ),
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      validator: (value) {
                        if (value.isEmpty || value.length < 4) {
                          return '4 characters required';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userName = value;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Username',
                      ),
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value.isEmpty || value.length < 7) {
                        return '7 characters required';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userPass = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 12),
                  if (widget.isloading) CircularProgressIndicator(),
                  if (!widget.isloading)
                    RaisedButton(
                      child: Text(_isLogin ? 'Login' : 'Register'),
                      onPressed: () {
                        _submit();
                      },
                    ),
                  SizedBox(height: 2),
                  if (!widget.isloading)
                    FlatButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        color: Theme.of(context).primaryColor,
                        child: Text(
                            _isLogin ? 'New User?' : 'Already have an Account'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
