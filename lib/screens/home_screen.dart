// @dart=2.9
// ignore_for_file: deprecated_member_use, unused_local_variable, missing_return
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
import 'login_screen.dart';
// import 'package:geocode/geocode.dart';
// import 'package:geocoder2/geocoder2.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key, this.locationData}) : super(key: key);
  static const String id = 'home-screen';
  final LocationData locationData;
  // HomeScreen({this.locationData});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String address = 'laos';
  LocationData currentLocation;
  // String address = "";

  // Future<String> getAddress(double lat, double lang) async {
  //   if (lat == null || lang == null) return "";
  //   GeoCode geoCode = GeoCode();

  //   Address address =
  //       await geoCode.reverseGeocoding(latitude: lat, longitude: lang);

  //   return "${address.streetAddress}, ${address.city}, ${address.countryName}, ${address.postal}";
  // }

  // Future<String> getAddress() async {
  //   GeoCode geoCode = GeoCode();

  //   try {
  //     Coordinates coordinates = await geoCode.forwardGeocoding(address: "Laos");

  //     print("Latitude: ${coordinates.latitude}");
  //     print("Longitude: ${coordinates.longitude}");
  //   } catch (e) {
  //     print(e);
  //   }
  // }

//we are getting lattiude and longitude from the locationData, no we need to exact address
  Future<String> getAddress() async {
    // From coordinates
    final coordinates = new Coordinates(
        widget.locationData.latitude, widget.locationData.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print("${first.featureName} : ${first.addressLine}");
    setState(() {
      address = first.addressLine;
    });
    return first.addressLine;
  }

  @override
  void initState() {
    super.initState();
    getAddress();
    // getAddress(widget.locationData.latitude, widget.locationData.longitude);
    // print(getAddress);
  }

  // ignore: unused_element
  static Future<bool> checkInternetConnectivity() async {
    bool isConnected;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      }
    } on SocketException catch (_) {
      isConnected = false;
    }
    return isConnected;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: InkWell(
          onTap: () {},
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Row(
                children: <Widget>[
                  if (currentLocation != null)
                    Text(
                        "Location: ${currentLocation?.latitude}, ${currentLocation?.longitude}"),
                  if (currentLocation != null) Text("Address: $address"),
                  // MaterialButton(
                  //   onPressed: () {
                  //     getLocation().then((value) {
                  //       LocationData location = value;
                  //       getAddress(location?.latitude, location?.longitude)
                  //           .then((value) {
                  //         setState(() {
                  //           currentLocation = location;
                  //           address = value;
                  //         });
                  //       });
                  //     });
                  //   },
                  // ),
                  Icon(
                    CupertinoIcons.location_solid,
                    color: Colors.black,
                    size: 18,
                  ),
                  Flexible(
                    child: Text(
                      address,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: Colors.black,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Sign Out'),
          onPressed: () {
            FirebaseAuth.instance.signOut().then((value) => {
                  Navigator.pushReplacementNamed(context, LoginScreen.id),
                });
          },
        ),
      ),
    );
  }
}

Future<LocationData> getLocation() async {
  Location location = new Location();
  LocationData _locationData;

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

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

  return _locationData;
}

// Future<String> getAddress(double lat, double lang) async {
//   if (lat == null || lang == null) return "";
//   GeoCode geoCode = GeoCode();
//   Address address =
//       await geoCode.reverseGeocoding(latitude: lat, longitude: lang);
//   return "${address.streetAddress}, ${address.city}, ${address.countryName}, ${address.postal}";
// }
