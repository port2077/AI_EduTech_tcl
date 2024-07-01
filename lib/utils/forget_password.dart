import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcl_global/screens/reset_password_landing_page.dart';

Future<void> resetPassword(BuildContext context, String email) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

    if (context.mounted) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Password Reset'),
            content: Text('Password reset email sent'),
            actions: <Widget>[
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ResetPasswordLandingPage(email: email)));
                },
              ),
            ],
          );
        },
      );
    }
  } on FirebaseAuthException catch (e) {
    String errorMessage;
    switch (e.code) {
      case 'invalid-email':
        errorMessage = 'Invalid email address';
        break;
      case 'user-not-found':
        errorMessage = 'No user found with this email';
        break;
      default:
        errorMessage = 'An error occurred. Please try again later';
    }

    if (context.mounted) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(errorMessage),
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
  } catch (e) {
    if (context.mounted) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('An unexpected error occurred'),
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
  }
}
