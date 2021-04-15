import 'package:crave_coffee/models/user.dart';
import 'package:crave_coffee/services/database.dart';
import 'package:crave_coffee/shared/contants.dart';
import 'package:crave_coffee/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyBottomSheet extends StatefulWidget {
  MyBottomSheet({Key key}) : super(key: key);

  @override
  _MyBottomSheetState createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  //form Values
  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User1>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      "Update your Coffee Settings",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    TextFormField(
                      initialValue: userData.name,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  width: 3, color: Colors.brown[400]))),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter your name' : null,
                      onChanged: (val) => setState(() => _currentName = val),
                    ),
                    SizedBox(height: 10.0),
                    //dropdown
                    DropdownButtonFormField(
                      value: _currentSugars ?? userData.sugars,
                      decoration: textInputDecoration,
                      dropdownColor: Colors.brown[50],
                      items: sugars.map((sugar) {
                        return DropdownMenuItem(
                          value: sugar,
                          child: Text('$sugar sugars'),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _currentSugars = val),
                    ),
                    SizedBox(height: 25),
                    //Slider
                    Slider(
                        value:
                            (_currentStrength ?? userData.strength).toDouble(),
                        min: 100,
                        max: 900,
                        divisions: 8,
                        activeColor:
                            Colors.brown[_currentStrength ?? userData.strength],
                        inactiveColor:
                            Colors.brown[_currentStrength ?? userData.strength],
                        onChanged: (value) {
                          setState(() {
                            _currentStrength = value.round();
                          });
                        }),
                    //button
                    Center(
                      child: InkWell(
                        onTap: () async {
                          if (_formKey.currentState.validate()) {
                            await DatabaseService(uid: user.uid).updateUserData(
                                _currentSugars ?? userData.sugars,
                                _currentName ?? userData.name,
                                _currentStrength ?? userData.strength);
                          }
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 50,
                          width: 105,
                          decoration: BoxDecoration(
                              color: Colors.brown[800],
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                            child: Text("Update",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
