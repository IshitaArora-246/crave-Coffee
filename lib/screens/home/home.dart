import 'package:crave_coffee/models/brew.dart';
import 'package:crave_coffee/services/auth.dart';
import 'package:crave_coffee/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:crave_coffee/screens/home/brew_list.dart';
import 'package:provider/provider.dart';


class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      initialData: [],
      child: Scaffold(
          backgroundColor: Colors.brown[100],
          appBar: AppBar(
            title: Text("Crave coffee",
                style: TextStyle(color: Colors.brown[800])),
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              TextButton(
                  onPressed: () async {
                    await _auth.signOut();
                    print("Signed out");
                  },
                  child: Icon(
                    Icons.login_rounded,
                    color: Colors.brown[800],
                  ))
            ],
          ),
          body: BrewList()),
    );
  }
}
