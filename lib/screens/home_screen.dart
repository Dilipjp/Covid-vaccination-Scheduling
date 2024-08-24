import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatelessWidget {
  final String title;
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  // Sign-Out method
  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/sign-in');
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve the current user's email for display
    final User? user = FirebaseAuth.instance.currentUser;
    final String userEmail = user?.email ?? 'No Email';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          // Sign-Out button
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _signOut(context),
            tooltip: 'Sign Out',
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Welcome, $userEmail!',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
