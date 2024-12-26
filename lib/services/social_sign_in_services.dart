import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:template_flutter_mvvm_repo_bloc/root_app.dart';
class SocialSignInServices{


 static Future<UserCredential?> signInWithGoogle() async {
  try{
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    if(googleAuth?.accessToken != null && googleAuth?.idToken != null){
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential;
    }
    else{
      return null;
    }

  }
  on FirebaseAuthException catch (e) {
    if (e.code == 'account-exists-with-different-credential') {
      throw Exception(e.toString());
    }
    else if (e.code == 'invalid-credential') {
      throw Exception(e.toString());
    }
  } catch (e){
    throw Exception(e.toString());
  }
 }
 static Future<FacebookLogin?>signInWithFacebook() async {
   try {
     FacebookLogin facebookLogin = FacebookLogin(debug: false);
     FacebookLoginResult facebookLoginResult = await facebookLogin.logIn(permissions: [
       FacebookPermission.publicProfile,
       FacebookPermission.email,
     ]);
     if (facebookLoginResult.status == FacebookLoginStatus.success) {
       return facebookLogin;
     }else{
       return null;
     }
   } catch (e) {
     ScaffoldMessenger.of(navigatorKey.currentState!.context).showSnackBar(
         SnackBar(content: Text(e.toString()),));
     throw Exception(e.toString());
   }
 }

}
