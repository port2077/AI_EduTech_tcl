// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcl_global/pages/demo_logout.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailVerificationPage extends StatefulWidget {
  final String email;

  const EmailVerificationPage({super.key, required this.email});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage>
    with WidgetsBindingObserver {
  late Timer _timer;
  bool _isEmailVerified = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkEmailVerified();
  }

  @override
  void dispose() {
    _timer.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkEmailVerified();
    }
  }

  Future<void> _checkEmailVerified() async {
    _isEmailVerified =
        FirebaseAuth.instance.currentUser?.emailVerified ?? false;

    if (_isEmailVerified) {
      _timer.cancel();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => DemoLogoutPage(loginMode: 'Email')),
      );
    } else {
      _timer = Timer.periodic(Duration(seconds: 5), (_) async {
        await FirebaseAuth.instance.currentUser?.reload();
        setState(() {
          _isEmailVerified =
              FirebaseAuth.instance.currentUser?.emailVerified ?? false;
        });
        if (_isEmailVerified) {
          _timer.cancel();
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) => DemoLogoutPage(loginMode: 'Email')),
          );
        }
      });
    }
  }

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
                            text: " Tap on the link to verify your account."),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                      if (Platform.isAndroid) {
                        final AndroidIntent intent = AndroidIntent(
                          action: 'android.intent.action.MAIN',
                          category: 'android.intent.category.APP_EMAIL',
                        );
                        await intent.launch();
                        SystemNavigator.pop();
                      } else if (Platform.isIOS) {
                        print('ios');
                        // For iOS, we'll show a simple dialog with common email apps
                        // showDialog(
                        //   context: context,
                        //   builder: (BuildContext context) {
                        //     return SimpleDialog(
                        //       title: Text('Choose Email App'),
                        //       children: <Widget>[
                        //         SimpleDialogOption(
                        //           onPressed: () {
                        //             launchUrl(Uri.parse('message://'));
                        //             Navigator.pop(context);
                        //           },
                        //           child: Text('Mail'),
                        //         ),
                        //         SimpleDialogOption(
                        //           onPressed: () {
                        //             launchUrl(Uri.parse('googlegmail://'));
                        //             Navigator.pop(context);
                        //           },
                        //           child: Text('Gmail'),
                        //         ),
                        //         // Add more options for other email apps as needed
                        //       ],
                        //     );
                        //   },
                        // );
                      }
                    },
                    child: Text(
                      'Open Email App',
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
