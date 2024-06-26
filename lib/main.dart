import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tcl_global/pages/email_registration_pag.dart';
import 'package:tcl_global/pages/email_verification_page.dart';
import 'package:tcl_global/pages/login_page.dart';
import 'package:tcl_global/pages/password_reset_page.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure plugin services are initialized
  await Firebase.initializeApp();
  runApp(const TCL_Global());
}

// FirebaseAnalytics analytics = FirebaseAnalytics.instance;

// void testFirebase() {
//   analytics.logEvent(
//     name: 'test_event',
//     parameters: <String, Object>{
//       'string': 'test',
//       'int': 42,
//       'long': 12345678910,
//       'double': 42.0,
//     },
//   );
// }

class TCL_Global extends StatelessWidget {
  const TCL_Global({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TCL Global',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home:
            PasswordResetPage() //EmailVerificationPage(email: 'test@test.com'),
        );
  }
}
