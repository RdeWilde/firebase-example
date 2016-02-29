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
  Map<String, int> _result;
  String _toolbarText;

  void initState() {
    super.initState();
    _toolbarText = "Flutter Firebase Example";
    _listen();
  }

  void _listen() {
    Map<String, String> credentials = {
      "email": "jackson@google.com",
      "password": "testing"
    };
    _firebase = new Firebase("https://burning-inferno-5689.firebaseio.com/");
    _firebase.authWithPassword(credentials)
      .then((Map<String, dynamic> result) {
        setState(() {
          _toolbarText = "Logged in as ${result['uid']}";
        });
      });
    _firebase.child("hello")
      .onValue
      .forEach((Event event) {
        setState(() {
          _result = event.snapshot.val();
        });
      });
  }

  void _handleActionButtonPressed() {
    // This should only work if the user is authenticated
    _result.putIfAbsent("count", () => 0);
    _firebase.child("hello").set({ "count": _result["count"] + 1 });
    // _firebase.child("hello").push(value: { "world": true }, onComplete: (error) {
    //  print("Done! $error");
    // });
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
        center: new Text(_toolbarText)
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
