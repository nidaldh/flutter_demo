import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_demo/screens/email_form.dart';
import 'package:instagram_demo/screens/feed_screen.dart';
import 'package:instagram_demo/screens/login_screen.dart';
import 'package:instagram_demo/screens/signup_screen.dart';
import 'package:instagram_demo/services/cofig_php.dart';

import 'screens/auto_complete .dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  Widget _getScreenId(){
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot){
        if(snapshot.hasData){
          return FeedScreen();
        }else{
          return LoginScreen();
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
//      home: _getScreenId(),
      home: EmailForm(),
//      home: CompliteDemo(),
//      home: ConfigPHP(),
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        SignupScreen.id: (context) => SignupScreen(),
        FeedScreen.id: (context) => FeedScreen()
      },
    );
  }
}

