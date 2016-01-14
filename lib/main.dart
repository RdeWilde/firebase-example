import 'dart:async';
import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    new MaterialApp(
      title: "Flutter Firebase Example",
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

  Firebase _firebase;
  String _result;

  void initState() {
    super.initState();
    _result = "Connecting to Firebase...";
    _listen();
  }

  Future _listen() async {
    _firebase = new Firebase("https://burning-inferno-5689.firebaseio.com/")
      ..child("hello")
      .onValue
      .forEach((Event event) {
        setState(() {
          _result = "${event.snapshot.key}, ${event.snapshot.val()}!";
        });
      });
  }

  Future _reload() async {
    setState(() {
      _result = "Reloading from Firebase...";
    });
    _listen();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      toolBar: new ToolBar(
        center: new Text("Flutter Firebase Example")
      ),
      body: new Material(
        child: new Center(
          child: new Text(_result)
        )
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _reload,
        child: new Icon(
          icon: 'navigation/refresh'
        )
      )
    );
  }
}
