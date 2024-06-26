// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:tcl_global/controllers/email_registration.dart';
import 'package:tcl_global/controllers/google_sign_in.dart';
import 'package:tcl_global/pages/demo_logout.dart';
import 'package:tcl_global/pages/email_registration_pag.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    // Method to toggle password visibility
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _checkUserSignInStatus();
  // }

  // void _checkUserSignInStatus() {
  //   if (LogInwithGoogle.isUserSignedIn()) {
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(builder: (context) => DemoLogoutPage()),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 80),
                Text(
                  'Login into your account',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Welcome back! Please enter your details.',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                SizedBox(height: 32),
                Text('Email ',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Enter your Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                Text('Password ',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                TextField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'Enter your password',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Checkbox(value: false, onChanged: (bool? value) {}),
                    Text('Remember me'),
                    Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: Text('Forget Password?'),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    if (_emailController.text.isEmpty ||
                        _passwordController.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Error'),
                            content: Text(
                                'Email and password fields cannot be empty'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('Close'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                      return;
                    }
                    try {
                      List result = await EmailRegistration().signInWithEmail(
                        _emailController.text,
                        _passwordController.text,
                      );
                      if (result[1] == 'Email') {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) =>
                                DemoLogoutPage(loginMode: 'Email'),
                          ),
                        );
                      }
                    } catch (error) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Error'),
                            content: Text(error.toString()),
                            actions: <Widget>[
                              TextButton(
                                child: Text('Close'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 17, 28, 194),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'or',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
                SizedBox(height: 12),
                SignInButton(
                  Buttons.google,
                  text: "Sign up with Google",
                  onPressed: () async {
                    try {
                      final List userDetails = await LogInwithGoogle.signIn();
                      final User user = userDetails[0];
                      final String loginMode = userDetails[1];

                      if (loginMode == 'Google') {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DemoLogoutPage(
                                  loginMode: loginMode,
                                )));
                      } else {
                        Fluttertoast.showToast(
                          msg: "Invalid User",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                      //print(user);
                    } on FirebaseException catch (error) {
                      Fluttertoast.showToast(
                        msg: "Authentication failed",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                      );
                    } catch (e) {
                      Fluttertoast.showToast(
                        msg: "Authentication failed",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                      );
                    }
                  },
                ),
                SignInButton(
                  Buttons.apple,
                  text: "Sign up with Apple",
                  onPressed: () {},
                ),

                // OutlinedButton.icon(
                //   onPressed: () {},
                //   //icon: Image.asset('assets/google_logo.png', height: 24),
                //   label: Text('Sign in with Google'),
                //   style: OutlinedButton.styleFrom(
                //     side: BorderSide(color: Colors.blue),
                //     padding: EdgeInsets.symmetric(vertical: 12),
                //   ),
                // ),
                // SizedBox(height: 16),
                // OutlinedButton.icon(
                //   onPressed: () {},
                //   //icon: Image.asset('assets/apple_logo.png', height: 24),
                //   label: Text('Sign in with Apple'),
                //   style: OutlinedButton.styleFrom(
                //     side: BorderSide(color: Colors.blue),
                //     padding: EdgeInsets.symmetric(vertical: 12),
                //   ),
                // ),
                SizedBox(height: 8),
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(text: 'Don\'t have an account? '),
                        TextSpan(
                          text: 'Sign Up',
                          style: TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EmailRegistrationPage(),
                              ));
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
