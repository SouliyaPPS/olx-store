import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);
  static const String id = 'ResetPasswordScreen';
  @override
  Widget build(BuildContext context) {
    var _emailController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.lock,
                color: Theme.of(context).primaryColor,
                size: 75,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Forgot \nPassword?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Send your email, \nwe will send link to reset your password',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                textAlign: TextAlign.center,
                // obscureText: true,
                controller: _emailController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10),
                  labelText: 'Register Email',
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  //need to check email entered is a valid email or not. we will use package for that
                  final bool isValid =
                      EmailValidator.validate(_emailController.text);
                  if (value == null || value.isEmpty) {
                    return 'Enter email';
                  }
                  if (value.isNotEmpty && isValid == false) {
                    return 'Enter valid email';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Theme.of(context).primaryColor,
            shape: new RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            )),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Send'),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            //it will check email entered or not
            FirebaseAuth.instance
                .sendPasswordResetEmail(email: _emailController.text)
                .then(
              (value) {
                Navigator.pop(context);
              },
            );
          }
        },
      ),
    );
  }
}
