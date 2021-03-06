import 'package:doctoradmin_app/app/sign_in/sign_in_button.dart';
import 'package:doctoradmin_app/app/sign_in/social_sign_in_button.dart';
import 'package:doctoradmin_app/services/auth.dart';
import 'package:flutter/material.dart';

import 'email_sign_in_page.dart';


class SignInPage extends StatelessWidget {
  SignInPage({@required this.auth});
  final AuthBase auth;


  Future<void> _signInWithGoogle() async {
    try {
      await auth.signInWithGoogle();

    } catch (e) {
      print(e.toString());
    }
  }



  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => EmailSignInPage(auth: auth),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContent(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: ListView(
        children:[ Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 150,
            ),
            Image.asset('images/hello3.png'),
            SizedBox(height: 48.0),
            SocialSignInButton(
              assetName: 'images/google-logo.png',
              text: 'Sign in with Google',
              textColor: Colors.black87,
              color: Colors.white,
              onPressed: _signInWithGoogle,
            ),
            SizedBox(height: 8.0),

            Text(
              'or',
              style: TextStyle(fontSize: 14.0, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0),
            SignInButton(
              text: 'Sign in with email',
              textColor: Colors.white,
              color: Colors.teal,
              onPressed: () => _signInWithEmail(context),
            ),


          ],
        ),
      ]
      ),
    );
  }
}
