import 'package:crave_coffee/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Home extends StatelessWidget {
  // const Home({Key key}) : super(key: key);
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          title:
              Text("Crave coffee", style: TextStyle(color: Colors.brown[800])),
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
        body: Container(
          child: Column(children: []),
        ));
  }
}
