// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:tcl_global/utils/email_registration.dart';
import 'package:tcl_global/utils/google_sign_in.dart';
import 'package:tcl_global/utils/password_validator.dart';
import 'package:tcl_global/utils/dialogue_box.dart';
import 'package:tcl_global/screens/demo_logout.dart';
import 'package:tcl_global/screens/email_verification_page.dart';
import 'package:tcl_global/screens/login_page.dart';
import 'package:email_validator/email_validator.dart';

class EmailRegistrationPage extends StatefulWidget {
  const EmailRegistrationPage({super.key});

  @override
  _EmailRegistrationPageState createState() => _EmailRegistrationPageState();
}

class _EmailRegistrationPageState extends State<EmailRegistrationPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isPasswordVisible = false;
  bool _isTermsAccepted = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  bool _isFormValid() {
    return _firstNameController.text.isNotEmpty &&
        _lastNameController.text.isNotEmpty &&
        EmailValidator.validate(_emailController.text) &&
        _passwordController.text.passwordError != 'error' &&
        _confirmPasswordController.text == _passwordController.text &&
        _isTermsAccepted;
  }

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
                SizedBox(height: 10),
                Text(
                  'Create an account',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'Welcome! Please enter your details.',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                SizedBox(height: 15),
                buildInputField('First Name', _firstNameController,
                    'Enter your first name'),
                SizedBox(height: 8),
                buildInputField(
                    'Last Name', _lastNameController, 'Enter your last name'),
                SizedBox(height: 8),
                buildInputField('Email', _emailController, 'Enter your email',
                    keyboardType: TextInputType.emailAddress),
                SizedBox(height: 8),
                buildPasswordField('Create Password', _passwordController,
                    'Enter your password'),
                SizedBox(height: 8),
                buildPasswordField('Confirm Password',
                    _confirmPasswordController, 'Confirm your password'),
                SizedBox(height: 8),
                Row(
                  children: [
                    Checkbox(
                      value: _isTermsAccepted,
                      onChanged: (bool? value) {
                        setState(() {
                          _isTermsAccepted = value ?? false;
                        });
                      },
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(fontSize: 12, color: Colors.black),
                          children: [
                            TextSpan(text: 'Agree the '),
                            TextSpan(
                              text: 'terms of laws',
                              style: TextStyle(color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  TermsDialog.show(
                                    context,
                                    'Terms and Conditions',
                                    'assets/markdown/terms_and_policy.md',
                                  );
                                },
                            ),
                            TextSpan(text: ' and '),
                            TextSpan(
                              text: 'privacy policy',
                              style: TextStyle(color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  TermsDialog.show(
                                    context,
                                    'Privacy Policy',
                                    'assets/markdown/privacy_policy.md',
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () async {
                    if (!_isTermsAccepted) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Terms Not Accepted'),
                            content: Text(
                                'Please accept the terms and conditions to proceed.'),
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
                    } else if (_isFormValid()) {
                      print('Email: ${_emailController.text}');
                      print('Password: ${_passwordController.text}');

                      try {
                        User? user = await EmailRegistration().signUpWithEmail(
                            _emailController.text,
                            _confirmPasswordController.text);
                        if (user != null) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EmailVerificationPage(
                                  email: _emailController.text),
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
                    } else {
                      String errorMessage = '';
                      if (_firstNameController.text.isEmpty) {
                        errorMessage += 'First name is required.\n';
                      }
                      if (_lastNameController.text.isEmpty) {
                        errorMessage += 'Last name is required.\n';
                      }
                      if (!EmailValidator.validate(_emailController.text)) {
                        errorMessage += 'Invalid email address.\n';
                      }
                      if (_passwordController.text.passwordError == 'error') {
                        errorMessage +=
                            'Password does not meet requirements.\n';
                      }
                      if (_confirmPasswordController.text !=
                          _passwordController.text) {
                        errorMessage += 'Passwords do not match.\n';
                      }
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Error'),
                            content: Text(errorMessage.trim()),
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
                    backgroundColor: _isTermsAccepted
                        ? Color.fromARGB(255, 17, 28, 194)
                        : Colors.grey[300],
                    foregroundColor:
                        _isTermsAccepted ? Colors.white : Colors.grey[600],
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Sign up',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'or continue with',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
                SizedBox(height: 10),
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
                            builder: (context) =>
                                DemoLogoutPage(loginMode: loginMode)));
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
                SizedBox(height: 10),
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 12),
                      children: [
                        TextSpan(text: 'Already have an account? '),
                        TextSpan(
                          text: 'Sign In',
                          style: TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LoginPage(),
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

  Widget buildInputField(
    String label,
    TextEditingController controller,
    String hintText, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
        SizedBox(height: 4),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            errorText: label == 'Email' &&
                    controller.text.isNotEmpty &&
                    !EmailValidator.validate(controller.text)
                ? 'Invalid email address'
                : null,
          ),
          onChanged: (value) {
            if (label == 'Email') {
              setState(() {});
            }
          },
        ),
      ],
    );
  }

  Widget buildPasswordField(
      String label, TextEditingController controller, String hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
        SizedBox(height: 4),
        TextField(
          controller: controller,
          obscureText: !_isPasswordVisible,
          decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: _togglePasswordVisibility,
              ),
              errorText: label == 'Create Password' &&
                      controller.text.isNotEmpty
                  ? controller.text.passwordError == 'error'
                      ? 'Password must contain atleast one uppercase,one lowercase,one digit, and one special character'
                      : null
                  : label == 'Confirm Password' &&
                          controller.text != _passwordController.text
                      ? 'Passwords do not match'
                      : null),
          onChanged: (value) {
            setState(() {});
          },
        ),
      ],
    );
  }
}
