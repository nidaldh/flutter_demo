import 'dart:convert';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:instagram_demo/classes/user.dart';

class CompliteDemo extends StatefulWidget {
  @override
  _CompliteDemoState createState() => _CompliteDemoState();
}

///https://jsonplaceholder.typicode.com/users
class _CompliteDemoState extends State<CompliteDemo> {
  static List<User> user = new List<User>();
  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<User>> key = new GlobalKey();
  bool loading = true;

  void getUser() async {
    try {
      final response =
          await http.get("https://jsonplaceholder.typicode.com/users");
      if (response.statusCode == 200) {
        user = loadUser(response.body);
        print("number of user = ${user.length}");
        setState(() {
          loading = false;
        });
      } else
        throw ErrorDescription;
    } catch (e) {}
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  Widget row(User user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          user.name,
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(
          width: 10.0,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      appBar: AppBar(
        title: Text("Auto"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          loading
              ? CircularProgressIndicator()
              : searchTextField = AutoCompleteTextField<User>(
                  key: key,
                  clearOnSubmit: false,
                  suggestions: user,
                  style: TextStyle(color: Colors.red, fontSize: 16.0),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      hintStyle: TextStyle(color: Colors.green),
                      hintText: "Search Name"),
                  itemFilter: (item, query) {
                    return item.name
                        .toLowerCase()
                        .startsWith(query.toLowerCase());
                  },
                  itemSorter: (a, b) {
                    return a.name.compareTo(b.name);
                  },
                  itemSubmitted: (item) {
                    setState(() {
                      searchTextField.textField.controller.text = item.name;
                    });
                  },
                  itemBuilder: (context, item) {
                    return row(item);
                  },
                )
        ],
      ),
    );
  }

  static List<User> loadUser(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }
}
