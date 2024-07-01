// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../utils/forget_password.dart';

class PasswordResetPage extends StatefulWidget {
  // final String email;
  const PasswordResetPage({super.key});

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7F8),
      appBar: AppBar(
        backgroundColor: Color(0xFFF5F7F8),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 42),
              Text(
                'Forget Password?',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF191919),
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Submit your registered email address, and we will email you a link to reset your password.',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Color(0xFF8C8C8C),
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Email',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF191919),
                ),
              ),
              SizedBox(height: 4),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Enter your Email',
                  hintStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: Color(0xFF8C8C8C),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                    borderSide: BorderSide(color: Color(0xFF8C8C8C)),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 11),
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => resetPassword(context, _emailController.text),
                child: Text('Send reset link'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Color(0xFFF5F7F8),
                  backgroundColor: Color(0xFF0E68B2),
                  minimumSize: Size(double.infinity, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  textStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
