import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String userEmail = user?.email ?? "Unknown User";

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Successfully logged in as:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              userEmail,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pop(context);
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
