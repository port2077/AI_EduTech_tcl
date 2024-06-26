import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> resetPassword(BuildContext context, String email) async {
  try {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(
      email: email,
    )
        .then((_) {
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
                },
              ),
            ],
          );
        },
      );
    });
    Navigator.of(context).pop();
  } catch (e) {
    String errorMessage;
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'Invalid email address';
          break;
        case 'user-not-found':
          errorMessage = 'No user found with this email';
          print('No user found with this email');
          break;
        default:
          errorMessage = 'An error occurred. Please try again later';
      }
    } else {
      errorMessage = 'An unexpected error occurred';
    }
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
}
