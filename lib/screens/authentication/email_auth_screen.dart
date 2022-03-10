import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import '../../services/emailauth_service.dart';
import 'reset_password_screen.dart';

class EmailAuthScreen extends StatefulWidget {
  const EmailAuthScreen({Key? key}) : super(key: key);
  static const String id = 'email_auth_screen';
  @override
  State<EmailAuthScreen> createState() => _EmailAuthScreenState();
}

class _EmailAuthScreenState extends State<EmailAuthScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _validate = false;
  bool _login = false;
  bool _loading = false;
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  EmailAuthentication _service = EmailAuthentication();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  _validateEmail() {
    if (_formKey.currentState!.validate()) {
      //if email and password has entered
      setState(() {
        _validate = false;
        _loading = true;
      });
      _service
          .getAdminCredential(
            context: context,
            isLog: _login,
            password: _passwordController.text,
            email: _emailController.text,
          )
          .then((value) => {
                setState(() {
                  _loading = false;
                })
              });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Login',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
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
                //if _login == true it will show as login, else will show as register
                'Enter to ${_login ? 'login' : 'Register'}',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Enter Email and Password to  ${_login ? 'login' : 'Register'}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
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
                controller: _emailController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10),
                  labelText: 'Email',
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(
                  suffixIcon: _validate
                      ? IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            _passwordController.clear();
                            setState(() {
                              _validate = false;
                            });
                          },
                        )
                      : null,
                  contentPadding: EdgeInsets.only(left: 10),
                  labelText: 'Password',
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) {
                  if (_passwordController.text.isNotEmpty) {
                    if (value.length > 3) {
                      setState(() {
                        _validate = true;
                      });
                    } else {
                      setState(() {
                        _validate = false;
                      });
                    }
                  }
                },
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, ResetPasswordScreen.id);
                  },
                ),
              ),
              Row(children: [
                Text(_login ? 'New account ? ' : 'Already has an account?'),
                TextButton(
                    child: Text(
                      _login ? 'Register' : 'Login',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _login = !_login;
                      });
                    }),
              ]),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: AbsorbPointer(
            absorbing: _validate ? false : true,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: _validate
                    ? MaterialStateProperty.all(
                        Theme.of(context).primaryColor) //if validated
                    : MaterialStateProperty.all(Colors.grey), //if not validated
              ),
              onPressed: () {
                _validateEmail();
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: _loading
                    ? SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        '${_login ? 'login' : 'Register'}',
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
