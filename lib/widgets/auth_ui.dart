import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import '../screens/location_screen.dart';

class AuthUi extends StatelessWidget {
  const AuthUi({Key? key}) : super(key: key);

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
          onPressed: () {},
        ),
        SizedBox(height: 8),
        SignInButton(
          Buttons.FacebookNew,
          text: ('Continue with Facebook'),
          onPressed: () {},
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('OR',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Login with Email',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        )
      ],
    ));
  }
}
