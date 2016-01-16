# firebase_example

An example Firebase Flutter project.

## Setup

Make sure your checkouts of flutter and firebase-dart are in an adjacent directory. You should get your firebase-dart from https://github.com/flutter/firebase-dart for now.

Your copy of Flutter may need to have its 
packages/flutter/pubspec.yaml edited to point to a built sky_services if the interfaces
have changed recently.

```pub get```

```flutter start --debug``` (or ```--release```)

Until the ```flutter``` tool supports custom services, you'll need a
custom compiled Flutter engine with the Firebase Mojo service included.
You can do this adding

    registry.register(Firebase.MANAGER.getName(), new ServiceFactory() {
        @Override
        public void connectToService(Context context, Core core, MessagePipeHandle pipe) {
            Firebase.MANAGER.bind(new org.domokit.firebase.FirebaseImpl(context), pipe);
        }
    });

to the place where other services are registered ```SkyApplication.java```, and adding

    "//sky/services/firebase:firebase_lib"

to ```sky/shell/BUILD.gn```

