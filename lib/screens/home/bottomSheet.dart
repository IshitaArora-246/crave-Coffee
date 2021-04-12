import 'package:crave_coffee/shared/contants.dart';
import 'package:flutter/material.dart';

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
    return Form(
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
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        BorderSide(width: 3, color: Colors.brown[400]))),
            validator: (val) => val.isEmpty ? 'Please enter your name' : null,
            onChanged: (val) => setState(() => _currentName = val),
          ),
          SizedBox(height: 10.0),
          //dropdown
          DropdownButtonFormField(
            value: _currentSugars ?? '0',
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
              value: (_currentStrength ?? 100).toDouble(),
              min: 100,
              max: 900,
              divisions: 8,
              activeColor: Colors.brown[_currentStrength ?? 100],
              inactiveColor: Colors.brown[200],
              onChanged: (value) {
                setState(() {
                  _currentStrength = value.round();
                });
              }),
          //button
          Center(
            child: InkWell(
              onTap: () async {
                print(_currentName);
                print(_currentSugars);
                print(_currentStrength);
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
    );
  }
}
