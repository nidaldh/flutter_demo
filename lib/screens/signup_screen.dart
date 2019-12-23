import 'package:flutter/material.dart';
import 'package:instagram_demo/services/auth_service.dart';

class SignupScreen extends StatefulWidget {
  static final String id = 'sgnup_screen';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email, _password, _name;

  _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      AuthService.signupUser(context, _name, _email, _password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'name'),
                        validator: (input) => input.trim().isEmpty
                            ? 'Please enter username'
                            : null,
                        onSaved: (input) => _name = input,
                      )),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Email'),
                        validator: (input) => !input.contains('@')
                            ? 'Please enter correct email'
                            : null,
                        onSaved: (input) => _email = input,
                      )),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
                      child:
                          Text('Signup', style: TextStyle(color: Colors.white)),
                    ),
                  ),
//                SizedBox(height: 20),
                  Container(
                    width: 250.0,
                    child: FlatButton(
//                        onPressed: ()=> Navigator.pushNamed(context, LoginScreen.id),
                      onPressed: () => Navigator.pop(context),
                      color: Colors.blue,
                      padding: EdgeInsets.all(10.0),
                      child: Text('Back to Login',
                          style: TextStyle(color: Colors.white)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
