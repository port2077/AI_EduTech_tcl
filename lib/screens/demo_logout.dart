import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcl_global/utils/google_sign_in.dart';
import 'package:tcl_global/screens/login_page.dart';

class DemoLogoutPage extends StatelessWidget {
  final String loginMode;
  const DemoLogoutPage({Key? key, required this.loginMode}) : super(key: key);

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo Logout'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            if (loginMode == 'Google') {
              LogInwithGoogle.signOut();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => LoginPage()),
              );

              return;
            } else {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            }
            Navigator.of(context).pop();
          },
          child: Text('Log Out'),
        ),
      ),
    );
  }
}
