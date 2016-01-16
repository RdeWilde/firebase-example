# firebase_example

An example Flutter project using the Firebase SDK. It should run on both iOS and Android.

## Setup

Make sure your checkouts of flutter and firebase-dart are in an adjacent directory. You should get your firebase-dart from https://github.com/flutter/firebase-dart for now.

Your copy of Flutter may need to have its 
packages/flutter/pubspec.yaml edited to point to a built sky_services if the interfaces
have changed recently.

```pub get```

```flutter start --debug``` (or ```--release```)

Until the ```flutter``` tool supports custom services, you'll need a
custom compiled Flutter engine with the Firebase Mojo service included.
You can do this adding a custom dep:

    "custom_deps": { "src/third_party/firebase": "https://github.com/collinjackson/firebase-sdk.git@master" }

in your .gclient file and running ```gclient sync```.

Then make these changes to your engine (or cherry-pick)

https://github.com/collinjackson/flutter_engine/commit/d7cbc817934dd392866d13f839baef3e997f371f
