import 'package:crave_coffee/services/auth.dart';
import 'package:crave_coffee/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //Text field state
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text("Hello Again!\nWelcome Back",
                          style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown[800])),
                    ],
                  ),
                  SizedBox(height: 40),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (value) =>
                                value.isEmpty ? "Enter a valid E-mail" : null,
                            decoration: InputDecoration(
                                labelText: "E-mail",
                                labelStyle: TextStyle(color: Colors.brown[800]),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.brown[600],
                                    style: BorderStyle.solid,
                                    width: 1,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.brown))),
                            onChanged: (value) {
                              setState(() {
                                email = value;
                              });
                            },
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            validator: (value) => value.length < 7
                                ? "Length of Password should be more than 7 cahracters"
                                : null,
                            obscureText: true,
                            decoration: InputDecoration(
                                labelText: "Password",
                                labelStyle: TextStyle(color: Colors.brown[800]),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.brown[600],
                                    style: BorderStyle.solid,
                                    width: 1,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.brown))),
                            onChanged: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                          ),
                          SizedBox(height: 35),
                          Center(
                            child: InkWell(
                              onTap: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  dynamic result =
                                      await _auth.signInWithEmailAndPassword(
                                          email, password);
                                  if (result == null) {
                                    setState(() {
                                      error = 'Wrong credentials';
                                      loading = false;
                                    });
                                  }
                                }
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.brown[800],
                                    borderRadius: BorderRadius.circular(8)),
                                child: Center(
                                  child: Text("Sign-in",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text("Don't have an account?"),
                              TextButton(
                                onPressed: () {
                                  widget.toggleView();
                                },
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                      color: Colors.brown[500],
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          // Text(error)
                        ],
                      ))
                ],
              ),
            ),
          );
  }
}
