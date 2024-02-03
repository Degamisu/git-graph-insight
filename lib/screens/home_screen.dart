import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'github_signin_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GitGraph Insight'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to GitGraph Insight!',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
            onPressed: () {
                _handleSignIn(context);
            },
            child: Text('Sign In with GitHub'),
            ),

              child: Text('Sign In with GitHub'),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSignIn(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GitHubSignInScreen(),
      ),
    );
  }
}
