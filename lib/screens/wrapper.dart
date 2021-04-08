import 'package:crave_coffee/models/user.dart';
import 'package:crave_coffee/screens/authenticate/authenticate.dart';
import 'package:crave_coffee/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User1>(context);
    print(user);

    //return screen after checking if user is already logged in or not
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
