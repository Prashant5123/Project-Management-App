import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mangmentv103/pages/loginregister/login_page.dart';
import 'package:mangmentv103/pages/primarypage.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //usser is loged in
          if (snapshot.hasData == true) {
            return HomePage();
          } else {
            return LoginPage();
          }
          //user is loged out
        },
      ),
    );
  }
}
