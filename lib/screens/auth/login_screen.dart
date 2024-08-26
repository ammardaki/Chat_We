import 'dart:math';

import 'package:chat_we/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../home_screen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isAnimate = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _isAnimate = true;
      });
    });
  }

  _handleGoogleBtnClick() {
    _signInWithGoogle().then((user) {
      log('\nUser: ${user.user}' as num);
      log('\nUserAdditionalInfo: ${user.additionalUserInfo}' as num);

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const HomePage(),
        ),
      );
    });
  }

  Future<UserCredential> _signInWithGoogle() async {
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

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Welcome to ChatPlus",
        ),
      ),
      body: Stack(
        children: [
          AnimatedPositioned(
            top: mq.height * .15,
            right: _isAnimate ? mq.width * .25 : -mq.width * .5,
            width: mq.width * .5,
            duration: Duration(seconds: 1),
            child: Image.asset(
              "assets/images/icon.png",
            ),
          ),
          Positioned(
            bottom: mq.height * .15,
            left: mq.width * .05,
            width: mq.width * .9,
            height: mq.height * .06,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 219, 255, 178),
                  shape: const StadiumBorder(),
                  elevation: 1),
              onPressed: () {
                _handleGoogleBtnClick();
              },
              icon: Container(
                margin: EdgeInsets.only(left: 15),
                child: Image.asset(
                  "assets/images/google.png",
                  height: mq.height * .03,
                ),
              ),
              label: RichText(
                text: TextSpan(
                  style: GoogleFonts.lora(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  children: const [
                    TextSpan(
                      text: "Login with ",
                    ),
                    TextSpan(
                      text: 'Google',
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
