import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LogInwithGoogle {
  static User? user = FirebaseAuth.instance.currentUser;
  static GoogleSignInAccount? googleAccount;

  static Future<List> signIn() async {
    final googleAccount = await GoogleSignIn().signIn();

    final googleAuth = await googleAccount?.authentication;

    final credentials = GoogleAuthProvider.credential(
      idToken: googleAuth?.idToken,
      accessToken: googleAuth?.accessToken,
    );

    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credentials);

    user = userCredential.user;

    return [user, 'Google'];
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    try {
      if (googleAccount != null) {
        await GoogleSignIn().signOut();
        await googleAccount!.clearAuthCache();
        await GoogleSignIn().disconnect();
        googleAccount = null;
      }
    } catch (error) {
      print('Failed to disconnect: $error');
    }
  }

  static bool isUserSignedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }
}
