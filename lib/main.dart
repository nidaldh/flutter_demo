//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';
//import 'package:instagram_demo/screens/email_form.dart';
//import 'package:instagram_demo/screens/feed_screen.dart';
//import 'package:instagram_demo/screens/login_screen.dart';
//import 'package:instagram_demo/screens/main_screen.dart';
//import 'package:instagram_demo/screens/signup_screen.dart';
//import 'package:instagram_demo/services/cofig_php.dart';
//
//import 'screens/auto_complete .dart';
//
//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//
//  Widget _getScreenId(){
//    return StreamBuilder<FirebaseUser>(
//      stream: FirebaseAuth.instance.onAuthStateChanged,
//      builder: (BuildContext context, snapshot){
//        if(snapshot.hasData){
//          return FeedScreen();
//        }else{
//          return LoginScreen();
//        }
//      }
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      debugShowCheckedModeBanner: false,
////      home: _getScreenId(),
//      home: EmailForm(),
////      home: TileApp(),
////      home: CompliteDemo(),
////      home: ConfigPHP(),
//      routes: {
//        LoginScreen.id: (context) => LoginScreen(),
//        SignupScreen.id: (context) => SignupScreen(),
//        FeedScreen.id: (context) => FeedScreen()
//      },
//    );
//  }
//}
//

///copy form test_bloc
///
///
//import 'package:bloc_test/simple_bloc_delegate.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
//import 'authentication_bloc/bloc.dart';
//import 'data_layer/user_repository.dart';
//
//main() {
//  BlocSupervisor.delegate = SimpleBlocDelegate();
//  runApp(App());
//}
//
//import 'package:bloc_test/data_layer/user_repository.dart';
/////App will be a StatefulWidget because it will need to manage our AuthenticationBloc.
//class App extends StatefulWidget {
//  State<App> createState() => _AppState();
//}
//
//class _AppState extends State<App> {
//  final UserRepository _userRepository = UserRepository();
//  AuthenticationBloc _authenticationBloc;
//
//  //We create an instance of UserRepository in our _AppState class
//  // and then inject it into our AuthenticationBloc in initState
//  @override
//  void initState() {
//    super.initState();
//    _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);
//    _authenticationBloc.dispatch(AppStarted());
//  }
//
//
//  // We are using BlocProvider in order to make our _authenticationBloc
//  // instance available to the entire Widget sub-tree. We are also using
//  // BlocBuilder in order to render UI based on the _authenticationBloc state.
//  @override
//  Widget build(BuildContext context) {
//    return BlocProvider(
//      bloc: _authenticationBloc,
//      child: MaterialApp(
//        home: BlocBuilder(
//          bloc: _authenticationBloc,
//          builder: (BuildContext context, AuthenticationState state) {
//            return Container();
//          },
//        ),
//      ),
//    );
//  }
//
//  //Since we created the AuthenticationBloc in _AppState we need to clean up
//  // after ourselves and dispose of it in _AppState.
//  @override
//  void dispose() {
//    _authenticationBloc.dispose();
//    super.dispose();
//  }
//}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'improt_from_test_bloc/authentication_bloc/bloc.dart';
import 'improt_from_test_bloc/data_layer/user_repository.dart';
import 'improt_from_test_bloc/home_screen.dart';
import 'improt_from_test_bloc/screen/login_screen.dart';
import 'improt_from_test_bloc/simple_bloc_delegate.dart';
import 'improt_from_test_bloc/splash_screen.dart';



///App will be a StatelessWidget and be responsible for reacting to
/// the AuthenticationBloc state and rendering the appropriate widget.


void main() {
  //is required in Flutter v1.9.4+ before using any plugins if the code is executed before runApp.
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc(userRepository: userRepository)
        ..add(AppStarted()),
      child: App(userRepository: userRepository),
    ),
  );
}
///We are using BlocBuilder in order to render UI based on
/// the AuthenticationBloc state.
class App extends StatelessWidget {
  final UserRepository _userRepository;

  App({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Uninitialized) {
            return SplashScreen();
          }
          if (state is Unauthenticated) {
            return LoginScreen(userRepository: _userRepository);
          }
          if (state is Authenticated) {
            return HomeScreen(name: state.displayName);
          }
        },
      ),
    );
  }
}