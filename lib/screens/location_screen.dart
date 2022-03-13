// ignore_for_file: import_of_legacy_library_into_null_safe
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:country_state_city_pro/country_state_city_pro.dart';
// import 'package:csc_picker/csc_picker.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

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

  /// Variables to store country state city data in onChanged method.
  // String countryValue = "";
  // String stateValue = "";
  // String cityValue = "";
  // String address = "";

  late String countryValue;
  late String stateValue;
  late String cityValue;
  late String address;

//get currentLocation here
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
    ///Define Controller
    // TextEditingController country = TextEditingController();
    // TextEditingController state = TextEditingController();
    // TextEditingController city = TextEditingController();
    showBottomScreen(context) {
      showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: true,
        context: context,
        builder: (context) {
          return Column(
            children: [
              SizedBox(
                height: 26,
              ),
              AppBar(
                automaticallyImplyLeading: false,
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                elevation: 1,
                backgroundColor: Colors.white,
                title: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.clear,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Location',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: SizedBox(
                    height: 40,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Search City, area or neighbourhood',
                        hintStyle: TextStyle(color: Colors.grey),
                        icon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
              ),
              ListTile(
                onTap: () {},
                horizontalTitleGap: 0.0,
                leading: Icon(
                  Icons.my_location,
                  color: Colors.blue,
                ),
                title: Text(
                  'Use current location',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Enable location',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width, //screen size
                color: Colors.grey.shade300,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 4, right: 4),
                  child: Text(
                    'CHOOSE CITY',
                    style: TextStyle(
                      color: Colors.blueGrey.shade900,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: SelectState(
                  onCountryChanged: (value) {
                    setState(() {
                      countryValue = value;
                    });
                  },
                  onStateChanged: (value) {
                    setState(() {
                      stateValue = value;
                    });
                  },
                  onCityChanged: (value) {
                    setState(() {
                      cityValue = value;
                      address =
                          '$countryValue, $stateValue, ${cityValue.substring(8)}';
                    });
                    print(address);
                  },
                ),
              ),

              SizedBox(height: 20),

              // Padding(
              //   padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              //   child: CountryStateCityPicker(
              //     country: country,
              //     state: state,
              //     city: city,
              //     textFieldInputBorder: UnderlineInputBorder(),
              //   ),
              // ),

              // Text("${country.text}, ${state.text}, ${city.text}")

              // Padding(
              //   padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              //   child: CSCPicker(
              //     layout: Layout.vertical,
              //     // dropdownDecoration: BoxDecoration(shape: BoxShape.rectangle),
              //     defaultCountry: DefaultCountry.Laos,
              //     onCountryChanged: (value) {
              //       setState(() {
              //         countryValue = value;
              //       });
              //     },
              //     onStateChanged: (value) {
              //       setState(() {
              //         stateValue = value!;
              //       });
              //     },
              //     onCityChanged: (value) {
              //       setState(() {
              //         cityValue = value!;
              //         address =
              //             '$countryValue, $stateValue, ${cityValue.substring(8)}';
              //       });
              //       print(address);
              //     },
              //   ),
              // ),
            ],
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Image.asset(
            'assets/GPS.jpg',
            width: double.infinity,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height * 0.5,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Where do want\nto buy/sell products',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          SizedBox(height: 15),
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
                              'Set location',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          onPressed: () {
                            showBottomScreen(context);
                          },
                        ),
                ),
              ],
            ),
          ),

          // Padding(
          //   padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: _loading
          //             ? Center(
          //                 child: CircularProgressIndicator(
          //                 valueColor: AlwaysStoppedAnimation<Color>(
          //                     Theme.of(context).primaryColor),
          //               ))
          //             : ElevatedButton.icon(
          //                 style: ButtonStyle(
          //                   backgroundColor: MaterialStateProperty.all<Color>(
          //                       Theme.of(context).primaryColor),
          //                 ),
          //                 icon: Icon(CupertinoIcons.location_fill),
          //                 label: Padding(
          //                   padding: const EdgeInsets.only(top: 15, bottom: 15),
          //                   child: Text(
          //                     'Around me',
          //                     style: TextStyle(fontWeight: FontWeight.bold),
          //                   ),
          //                 ),
          //                 onPressed: () {
          //                   // FirebaseAuth.instance.signOut().then((value) {
          //                   //   Navigator.pushReplacementNamed(
          //                   //       context, LoginScreen.id);
          //                   // });
          //                   // FirebaseAuth.instance.signOut();
          //                   setState(() {
          //                     _loading = true;
          //                   });
          //                   getLocation().then(
          //                     (value) {
          //                       print(_locationData.latitude);
          //                       if (value != null) {
          //                         FirebaseAuth.instance.signOut();
          //                         Navigator.pushReplacement(
          //                           context,
          //                           MaterialPageRoute(
          //                             builder: (BuildContext context) =>
          //                                 HomeScreen(
          //                               locationData: _locationData,
          //                             ),
          //                           ),
          //                         );
          //                       }
          //                     },
          //                   );
          //                 },
          //               ),
          //       ),
          //     ],
          //   ),
          // ),

          // TextButton(
          //   onPressed: () {},
          //   child: Text('Set location manually',
          //       style: TextStyle(
          //         fontWeight: FontWeight.bold,
          //         color: Colors.black,
          //         fontSize: 18,
          //         decoration: TextDecoration.underline,
          //       )),
          // ),
        ],
      ),
    );
  }
}
