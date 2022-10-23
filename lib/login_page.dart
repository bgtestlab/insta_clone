import 'package:flutter/material.dart';
import 'sign_in_button.dart';
import 'authentication.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Insta Clone',
          style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: EdgeInsets.all(50.0),
        ),
        FutureBuilder(
          future: Authentication.initializeFirebase(context: context),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error initializing Firebase');
            } else if (snapshot.connectionState == ConnectionState.done) {
              return SignInButton();
            }
            return CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.blueAccent,
              ),
            );
          },
        ),
      ],
    )));
  }
}
