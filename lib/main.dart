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
  dynamic _result;

  void initState() {
    super.initState();
    _listen();
  }

  Future _listen() async {
    _firebase = new Firebase("https://burning-inferno-5689.firebaseio.com/")
      ..child("hello")
      .onValue
      .forEach((Event event) {
        setState(() {
          _result = event.snapshot.val();
        });
      });
  }

  void _handleActionButtonPressed() {
    setState(() {
      // TODO(jackson): Use a transaction to ensure atomicity
      _firebase.child("hello").set({ "count": _result["count"] + 1 });
    });
  }

  Widget _buildText() {
    if (_result == null)
      return new Text('Connecting to Firebase...');
    else
      return new Text("Button press $_result");
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      toolBar: new ToolBar(
        center: new Text("Flutter Firebase Example")
      ),
      body: new Material(
        child: new Center(
          child: _buildText()
        )
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _handleActionButtonPressed,
        child: new Icon(
          icon: 'content/add'
        )
      )
    );
  }
}
