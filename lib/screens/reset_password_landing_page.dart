// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcl_global/screens/login_page.dart';

class ResetPasswordLandingPage extends StatefulWidget {
  final String email;
  const ResetPasswordLandingPage({super.key, required this.email});

  @override
  State<ResetPasswordLandingPage> createState() =>
      _ResetPasswordLandingPageState();
}

class _ResetPasswordLandingPageState extends State<ResetPasswordLandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7F8),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFEFF3FE),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/emailVerification.png',
                      width: 242, height: 161),
                  SizedBox(height: 24),
                  Text(
                    'Check your Email',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF191919),
                    ),
                  ),
                  SizedBox(height: 4),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF8C8C8C),
                      ),
                      children: [
                        TextSpan(text: "We've just sent an email to you at "),
                        TextSpan(
                          text: widget.email,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF191919),
                          ),
                        ),
                        TextSpan(
                            text:
                                ", if it matches an existing account. Tap on the link to reset your password."),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text(
                      'Continue to Login',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0E68B2),
                      minimumSize: Size(double.infinity, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
