import 'package:flutter/material.dart';
import 'package:instagram_demo/screens/signup_screen.dart';
import 'package:instagram_demo/services/auth_service.dart';

import 'feed_screen.dart';

class LoginScreen extends StatefulWidget {
  static final String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email, _password;

  _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      AuthService.login(context, _email, _password);

      /// login with user and password to firebase
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('Instagram',
              style: TextStyle(
                fontSize: 50.0,
                fontFamily: 'Billabong',
              )),
          Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Email'),
                      validator: (input) => !input.contains('@')
                          ? 'Please enter correct email'
                          : null,
                      onSaved: (input) => _email = input,
                    )),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: TextFormField(
                      obscureText: true, //to by password
                      decoration: InputDecoration(labelText: 'Password'),
                      validator: (input) => input.length < 6
                          ? 'Password most be at least 6 charcter'
                          : null,
                      onSaved: (input) => _password = input,
                    )),
                SizedBox(height: 20),
                Container(
                  width: 250.0,
                  child: FlatButton(
                    onPressed: _submit,
                    color: Colors.blue,
                    padding: EdgeInsets.all(10.0),
                    child: Text('Login', style: TextStyle(color: Colors.white)),
                  ),
                ),
//                SizedBox(height: 20),
                Container(
                  width: 250.0,
                  child: FlatButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, SignupScreen.id),
                    color: Colors.blue,
                    padding: EdgeInsets.all(10.0),
                    child: Text('Go to signup',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                Container(
                  width: 250.0,
                  child: FlatButton(
                    onPressed: () {
                      AuthService.signInWithGoogle().whenComplete(() {
                        Navigator.pushReplacementNamed(context, FeedScreen.id);
                      });
                    },
                    color: Colors.blue,
                    padding: EdgeInsets.all(10.0),
                    child: Text('login with google account',
                        style: TextStyle(color: Colors.white)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
