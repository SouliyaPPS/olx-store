import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import '../screens/authentication/email_auth_screen.dart';
import '../screens/authentication/google_auth.dart';
import '../screens/location_screen.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthUi extends StatefulWidget {
  const AuthUi({Key? key}) : super(key: key);

  @override
  State<AuthUi> createState() => _AuthUiState();
}

class _AuthUiState extends State<AuthUi> {
  // ignore: unused_field
  bool _isSigningIn = false;
  // ignore: unused_field
  bool _isLoggedIn = false;
  // ignore: unused_field
  Map _userObj = {};

  // Future<UserCredential> signInWithFacebook() async {
  //   final LoginResult result = await FacebookAuth.instance.login();
  //   final FacebookAuthCredential facebookAuthCredential =
  //       FacebookAuthProvider.credential(result.accessToken.token);
  //   return await FirebaseAuth.instance
  //       .signInWithCredential(facebookAuthCredential);
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // SizedBox(
          //   width: 220,
          //   child: ElevatedButton(
          //     style: ButtonStyle(
          //       backgroundColor: MaterialStateProperty.all(Colors.white),
          //     ),
          //     child: Row(children: [
          //       Icon(
          //         Icons.phone_android_outlined,
          //         color: Colors.black,
          //       ),
          //       SizedBox(width: 8),
          //       Text(
          //         'Continue with Phone',
          //         style: TextStyle(color: Colors.black),
          //       )
          //     ]),
          //     onPressed: () {
          //       Navigator.pushNamed(context, PhoneAuthScreen.id);
          //     },
          //   ),
          // ),
          SizedBox(
            width: 220,
            child: ElevatedButton(
              style: ButtonStyle(
                alignment: Alignment.center,
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              child: Row(children: [
                Icon(
                  Icons.location_on_outlined,
                  color: Colors.black,
                ),
                SizedBox(width: 8),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 1.0),
                  child: Text(
                    'Continue with Location',
                    style: TextStyle(color: Colors.black),
                  ),
                )
              ]),
              onPressed: () {
                Navigator.pushNamed(context, LocationScreen.id);
              },
            ),
          ),
          SizedBox(height: 8),
          SignInButton(
            Buttons.GoogleDark,
            text: "Sign up with Google",
            onPressed: () async {
              // User? user =
              //     await GoogleAuthentication.signInWithGoogle(context: context);
              // GoogleAuthService _authentication = GoogleAuthService();
              // _authentication.addUser(context, user!.uid);

              // User? user =
              //     await GoogleAuthentication.signInWithGoogle(context: context);
              // if (user != null) {
              //   GoogleAuthService _authentication = GoogleAuthService();
              //   _authentication.addUser(context, user.uid);
              // }

              setState(() {
                _isSigningIn = true;
              });

              User? user =
                  await GoogleAuthentication.signInWithGoogle(context: context);

              setState(() {
                _isSigningIn = false;
              });

              if (user != null) {
                Navigator.pushNamed(context, LocationScreen.id);
              }
            },
          ),
          SizedBox(height: 8),
          // SignInButton(
          //   Buttons.FacebookNew,
          //   text: ('Continue with Facebook'),
          //   onPressed: () async {
          //     await signInWithFacebook();
          //     Navigator.pushNamed(context, LocationScreen.id);
          //   },
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('OR',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text(
          //     'Login with Email',
          //     style: TextStyle(
          //       color: Colors.white,
          //       fontWeight: FontWeight.bold,
          //       decoration: TextDecoration.underline,
          //     ),
          //   ),
          // )
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, EmailAuthScreen.id);
            },
            child: Container(
              child: Text(
                'Login with Email',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
