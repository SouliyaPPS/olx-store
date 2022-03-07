import 'package:flutter/material.dart';

class OTPScreen extends StatefulWidget {
  OTPScreen({Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Screen'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Text('OTP Screen'),
      ),
    );
  }
}
