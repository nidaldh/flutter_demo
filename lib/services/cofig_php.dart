import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ConfigPHP extends StatefulWidget {
  @override
  _ConfigPHPState createState() => _ConfigPHPState();
}

class _ConfigPHPState extends State<ConfigPHP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: FlatButton(
        onPressed: () => PHPConfig._deleteUser(2),
        child: Text('delete'),
      ),
    ));
  }
}

class PHPConfig {
  static void _deleteUser(var id) async {
    var url = "http://192.168.1.168/flutter/test_flutter/DeleteUser.php";
    var response = await http.post(url, body: {"userid": 2.toString()});
    if (response.statusCode == 200) {
      print("deleted");
    } else {
      print("error while deleted");
    }
    print(response.body);
  }
}

class Post {
  final int code;

  Post({this.code});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      code: json['code'],
    );
  }
}
