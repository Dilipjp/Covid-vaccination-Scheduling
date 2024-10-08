import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkUserSignInStatus();
  }

  void _checkUserSignInStatus() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate a splash screen delay

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // If the user is signed in, navigate to the home screen
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // If the user is not signed in, navigate to the sign-in screen
      Navigator.pushReplacementNamed(context, '/sign-in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/splash_logo.png', width: 600, height: 800),
            SizedBox(height: 20), // Space between image and progress indicator
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
