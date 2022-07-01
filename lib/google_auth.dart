import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthSignin extends StatefulWidget {
  const GoogleAuthSignin({Key? key}) : super(key: key);

  @override
  State<GoogleAuthSignin> createState() => _GoogleAuthSigninState();
}

class _GoogleAuthSigninState extends State<GoogleAuthSignin> {
  @override
  String userEmail = "";
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login with Google")),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("User Email"),
              Text(userEmail),
            ],
          ),
        ),
        ElevatedButton(
            onPressed: () async {
              await signInWithGoogle();
              setState(() {});
            },
            child: Text("Login")),
        ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();

              userEmail = "";
              await GoogleSignIn().signOut();
              setState(() {});
            },
            child: Text("Logout"))
      ]),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    userEmail = googleUser!.email;
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
