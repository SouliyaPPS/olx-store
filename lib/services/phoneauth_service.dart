import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/authentication/otp_screen.dart';

class PhoneAuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> verifyPhoneNumber(number, context) async {
    final PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential credential) async {
      await auth.signInWithCredential(
          credential); //after verification completed need to sign
    };
    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException e) {
      // if verification failed, it will show the reason
      if (e.code == 'invalid-phone-number') {
        print('The provided phone number is not valid');
      }
      print('The error is ${e.code}');
    };

    final PhoneCodeSent codeSent = (String verId, int? resentToken) async {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OTPScreen(),
        ),
      );
    };
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: number,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          timeout: const Duration(seconds: 60),
          codeAutoRetrievalTimeout: (String verificationId) {
            print(verificationId);
          });
    } catch (e) {
      // print('Error ${e.toString()}');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OTPScreen(),
        ),
      );
    }
  }
}
