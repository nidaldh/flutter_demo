
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_demo/improt_from_test_bloc/bloc/login_bloc.dart';
import 'package:instagram_demo/improt_from_test_bloc/data_layer/user_repository.dart';

import 'login_form.dart';

/*we are extending StatelessWidget and using a BlocProvider to initialize
 and close the LoginBloc as well as to make the LoginBloc instance available
 to all widgets within the sub-tree.*/

class LoginScreen extends StatelessWidget {
  final UserRepository _userRepository;

  LoginScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(userRepository: _userRepository),
        child: LoginForm(userRepository: _userRepository),
      ),
    );
  }
}
