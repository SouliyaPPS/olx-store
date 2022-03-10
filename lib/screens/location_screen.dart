// ignore_for_file: import_of_legacy_library_into_null_safe
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_web_a2hs/screens/home_screen.dart';
import 'package:location/location.dart';

import 'login_screen.dart';
// import 'login_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);
  static const String id = 'location-screen';

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  bool _loading = false;
  Location location = new Location();

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;

  Future<LocationData?> getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    _locationData = await location.getLocation();

    print(_locationData);

    return _locationData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Image.asset(
            'assets/GPS.jpg',
            width: double.infinity,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height * 0.5,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Text(
            'Where do want\nto buy/sell products',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Text(
            'to enjoy all that we have to offer you\nwe need to know where to look for them',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: _loading
                      ? Center(
                          child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor),
                        ))
                      : ElevatedButton.icon(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).primaryColor),
                          ),
                          icon: Icon(CupertinoIcons.location_fill),
                          label: Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 15),
                            child: Text(
                              'Around me',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          onPressed: () {
                            FirebaseAuth.instance.signOut().then((value) {
                              Navigator.pushReplacementNamed(
                                  context, LoginScreen.id);
                            });
                            FirebaseAuth.instance.signOut();
                            //   setState(() {
                            //     _loading = true;
                            //   });
                            //   getLocation().then(
                            //     (value) {
                            //       print(_locationData.latitude);
                            //       if (value != null) {
                            //         Navigator.pushReplacement(
                            //             context,
                            //             MaterialPageRoute(
                            //                 builder: (BuildContext context) =>
                            //                     HomeScreen(
                            //                       locationData: _locationData,
                            //                     )));
                            //       }
                            //     },
                            //   );
                          },
                        ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text('Set location manually',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 18,
                  decoration: TextDecoration.underline,
                )),
          ),
        ],
      ),
    );
  }
}
