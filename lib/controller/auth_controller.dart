import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/fileuploadin.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:get/get.dart'; // Import Get library for navigation
// ignore: unnecessary_import
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  googleLogin() async {
    GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        GoogleSignInAuthentication? googleSignInAuthentication =
            await googleSignInAccount.authentication;

        AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(authCredential);

        // Navigate to the new screen after successful login
        if (userCredential.user != null) {
          Get.to(() =>
              HomeScreen()); // Replace YourNewScreen with the actual screen
        }
      }
    } catch (error) {
      print("Error during Google login: $error");
    }
  }
}
