import 'dart:async';
import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    new MaterialApp(
      title: "Firebase Demo",
      routes: {
        '/': (RouteArguments args) => new FlutterDemo()
      }
    )
  );
}

class FlutterDemo extends StatefulComponent {
  State<FlutterDemo> createState() => new FlutterDemoState();
}

class FlutterDemoState extends State<FlutterDemo> {

  String _result = "Connecting to Firebase...";

  void initState() {
    super.initState();
    _testFirebase();
  }

  Future _testFirebase() async {
    setState(() {
      _result = "Reloading from Firebase...";
    });
    Firebase firebase = new Firebase("https://burning-inferno-5689.firebaseio.com/");
    DataSnapshot result = await firebase
      .child("hello")
      .once("value");
    setState(() {
      _result = "${result.key}, ${result.val()}!";
    });
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      toolBar: new ToolBar(
        center: new Text("Flutter Demo")
      ),
      body: new Material(
        child: new Center(
          child: new Text(_result)
        )
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _testFirebase,
        child: new Icon(
          icon: 'navigation/refresh'
        )
      )
    );
  }
}
