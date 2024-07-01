import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:tcl_global/screens/email_registration_pag.dart';
import 'package:tcl_global/screens/email_verification_page.dart';
import 'package:tcl_global/screens/homepage.dart';
import 'package:tcl_global/screens/login_page.dart';
import 'package:tcl_global/screens/password_reset_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tcl_global/screens/search_landing_page.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  runApp(const TCL_Global());
}

class TCL_Global extends StatelessWidget {
  const TCL_Global({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      FlutterNativeSplash.remove();
    });
    return MaterialApp(
        title: 'TCL Global',
        theme: ThemeData(
          fontFamily: 'Google Poppins',
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home:
            SearchLandingPage() //EmailVerificationPage(email: 'test@test.com'),
        );
  }
}
