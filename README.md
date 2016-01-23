# firebase_example

An example Flutter project using the Firebase SDK. It should run on both iOS and Android.

## Getting Started

Make sure your checkouts of flutter and firebase-dart are in directories that are adjacent to this one. You should get your firebase-dart from https://github.com/flutter/firebase-dart for now. In the firebase-example directory, run ```pub get```.

## Building for Android

```flutter apk```

```adb install -r build/app.apk```

## Building for iOS

Until the ```flutter``` tool supports custom iOS services, you'll
need a custom compiled Flutter engine with firebase enabled
to use Firebase on iOS. Contact jackson@google.com for help with this.
