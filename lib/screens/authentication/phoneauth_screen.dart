import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../services/phoneauth_service.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({Key? key}) : super(key: key);
  static const String id = 'phone-auth-screen';

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  bool validate = false;
  var countryCodeController = TextEditingController(text: '+85620');
  var phoneNumberController = TextEditingController();
  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
          ),
          SizedBox(width: 20),
          Text('Please wait...'),
        ],
      ),
    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  PhoneAuthService _service = PhoneAuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          'Login',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.red.shade200,
              child: Icon(
                CupertinoIcons.person_alt_circle,
                color: Colors.red,
                size: 60,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              'Enter your phone number',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'We will confirm your phone number and send you a code',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: countryCodeController,
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: 'Country',
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 3,
                  child: TextField(
                    autofocus: true,
                    maxLength: 8,
                    keyboardType: TextInputType.phone,
                    controller: phoneNumberController,
                    onChanged: (value) {
                      if (value.length == 8) {
                        setState(() {
                          validate = true;
                        });
                      }
                      if (value.length < 8) {
                        setState(() {
                          validate = false;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                        bottom: 22,
                        top: 22,
                      ),
                      labelText: 'Number',
                      hintText: 'Enter your number',
                      hintStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: AbsorbPointer(
            absorbing: validate ? false : true,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: validate
                    ? MaterialStateProperty.all(
                        Theme.of(context).primaryColor) //if validated
                    : MaterialStateProperty.all(Colors.grey), //if not validated
              ),
              onPressed: () {
                String number =
                    '${countryCodeController.text}${phoneNumberController.text}';
                //need to show loading
                showAlertDialog(context);

                _service.verifyPhoneNumber(context, number);
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Next',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
