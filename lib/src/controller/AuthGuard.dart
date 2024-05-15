import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:presence_jor/src/view/login_view.dart';

class AuthGuard extends StatelessWidget {
  final Widget child;

  AuthGuard({required this.child});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasData) {
          return child;
        } else {
          return LoginView(); // Redireciona para a página de login se não estiver autenticado
        }
      },
    );
  }
}
