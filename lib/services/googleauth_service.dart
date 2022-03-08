import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/location_screen.dart';

class GoogleAuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(context, uid) async {
    final QuerySnapshot result = await users.where('uid', isEqualTo: uid).get();

    List<DocumentSnapshot> document = result.docs;
    if (document.length > 0) {
      Navigator.pushReplacementNamed(context, LocationScreen.id);
    } else {
      return users.doc(user?.uid).set({
        'uid': user?.uid,
        'email': user?.email,
      }).then((value) {
        Navigator.pushReplacementNamed(context, LocationScreen.id);
      }).catchError(
        // ignore: invalid_return_type_for_catch_error
        (error) => print("Failed to add user: $error"),
      );
    }
  }
}
