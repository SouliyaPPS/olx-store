// ignore_for_file: import_of_legacy_library_into_null_safe
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_web_a2hs/screens/authentication/emai_verification_screen.dart';
import 'package:flutter_web_a2hs/screens/authentication/phoneauth_screen.dart';
import 'package:flutter_web_a2hs/screens/authentication/reset_password_screen.dart';
import 'screens/MyHomePage.dart';
import 'screens/authentication/email_auth_screen.dart';
import 'screens/home_screen.dart';
import 'screens/location_screen.dart';
import 'screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyBhsu6z6EVh29c5CAIAHU_PPQ5p38cd6Cw",
          authDomain: "olx-shop-8dd89.firebaseapp.com",
          projectId: "olx-shop-8dd89",
          storageBucket: "olx-shop-8dd89.appspot.com",
          messagingSenderId: "862569311274",
          appId: "1:862569311274:web:d5a650632eefeade406753",
          measurementId: "G-5WDKFJDY7C"),
    );
  }
  if (kIsWeb) {
    // initialiaze the facebook javascript SDK
    FacebookAuth.i.webInitialize(
      appId: "388204125990623", //<-- YOUR APP_ID
      cookie: true,
      xfbml: true,
      version: "v12.0",
    );
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OLX Shop',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("Error");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MyHomePage();
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
      initialRoute: MyHomePage.id,
      routes: {
        MyHomePage.id: (context) => MyHomePage(),
        LoginScreen.id: (context) => LoginScreen(),
        PhoneAuthScreen.id: (context) => PhoneAuthScreen(),
        LocationScreen.id: (context) => LocationScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        EmailAuthScreen.id: (context) => EmailAuthScreen(),
        EmailVerificationScreen.id: (context) => EmailVerificationScreen(),
        ResetPasswordScreen.id: (context) => ResetPasswordScreen(),
      },
    );
  }
}
