import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<Map<bool,String>> signInWithGoogle() async {

  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
  await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

  final Map<bool, String> map = {
    (user != null ? true : false): user.email,
  };
  return map;
}

Future<Map<bool,String>> signInWithFacebook() async {

  bool isLoggedIn = false;
  var profile;

  var facebookLogin = FacebookLogin();
  var facebookLoginResult = await facebookLogin.logIn(['email']);

  switch (facebookLoginResult.status) {
    case FacebookLoginStatus.error:
      print("Error");
      isLoggedIn = false;
      break;
    case FacebookLoginStatus.cancelledByUser:
      print("CancelledByUser");
      isLoggedIn = false;
      break;
    case FacebookLoginStatus.loggedIn:
      print("LoggedIn");
      var graphResponse = await http.get(
          'https://graph.facebook.com/v2.12/me?fields='
              'name,'
              'first_name,'
              'last_name,'
              'email,'
              'picture.height(200)'
              '&access_token=${facebookLoginResult.accessToken.token}');

      profile = json.decode(graphResponse.body);
      profile = profile.toString();
      isLoggedIn = true;
      break;
  }

  final Map<bool, String> map = {
    isLoggedIn: profile,
  };

  return map;
}

void signOutGoogle() async{
  await googleSignIn.signOut();
  print("Google User Signed Out");
}

abstract class BaseAuth {

  Future<String> signIn(String email, String password);
  Future<String> signUp(String email, String password);
  Future<FirebaseUser> getCurrentUser();
  Future<void> sendEmailVerification();
  Future<void> signOut();
  Future<bool> isEmailVerified();
}