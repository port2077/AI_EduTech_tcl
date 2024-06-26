import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EmailRegistration {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      if (user != null) {
        try {
          await user.sendEmailVerification();
          print('Verification email sent successfully');
        } catch (e) {
          print('Error sending verification email: $e');
        }
      }

      return user;
    } on FirebaseAuthException catch (error) {
      String errorMessage;
      switch (error.code) {
        case 'weak-password':
          errorMessage = 'The password provided is too weak.';
          break;
        case 'email-already-in-use':
          errorMessage = 'The account already exists for that email.';
          break;
        default:
          errorMessage = 'An error occurred during sign up.';
      }
      throw errorMessage;
    }
  }

  Future<List> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User? user = userCredential.user;
      return [user, 'Email'];
    } on FirebaseAuthException catch (error) {
      print('FirebaseAuthException: ${error.code}');
      print('Error message: ${error.message}');
      print('Error details: ${error.toString()}');
      if (error.stackTrace != null) {
        print('Stack trace: ${error.stackTrace.toString()}');
      }

      switch (error.code) {
        case 'user-not-found':
          throw 'No user found for that email.';
        case 'wrong-password':
          throw 'Wrong password provided for that user.';
        case 'invalid-email':
          throw 'The email address is badly formatted.';
        case 'invalid-credential':
          throw 'The supplied auth credential is incorrect, malformed or has expired.';
        default:
          throw 'An unexpected error occurred: ${error.message}';
      }
    } catch (error) {
      print('Unexpected error: ${error.toString()}');
      if (error is Error && error.stackTrace != null) {
        print('Stack trace: ${error.stackTrace.toString()}');
      }
      throw 'An unexpected error occurred: $error';
    }
  }
}
