import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sky_services/firebase/firebase.mojom.dart' as mojo;

void main() {
  runApp(
    new MaterialApp(
      title: "Flutter Demo",
      routes: {
        '/': (RouteArguments args) => new FlutterDemo()
      }
    )
  );
}

class FlutterDemo extends StatelessComponent {
  Future _onPressed() async {
    mojo.FirebaseProxy firebase = new mojo.FirebaseProxy.unbound();

    print("Demonstrating connection to Firebase...");
    shell.connectToService("firebase::Firebase", firebase);
    await firebase.ptr.initWithUrl("https://burning-inferno-5689.firebaseio.com/hello");
    var result = await firebase.ptr.observeSingleEventOfType(mojo.EventType.EventTypeValue);
    print("Result: ${result}");

    print("Authenticating...");
    mojo.FirebaseAuthWithOAuthTokenResponseParams response = await firebase.ptr.authWithOAuthToken(
      "google",
      "<PROVIDER TOKEN>"
    );
    if (response.error != null) {
      print("Authentication Failed! ${response.error.code} ${response.error.message}");
    } else {
      print("Authenticated successfully with payload: ${response.authData}");
    }
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      toolBar: new ToolBar(
        center: new Text("Flutter Demo")
      ),
      body: new Material(
        child: new Center(
          child: new Text("Hello world!")
        )
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _onPressed,
        child: new Icon(
          icon: 'content/add'
        )
      )
    );
  }
}
