import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GitHubSignInScreen extends StatelessWidget {
  final String clientId = 'dbee0b940a5d97bab2b5';
  final String redirectUri = 'http://localhost:3000/callback';
  final String authorizationUrl = 'https://github.com/login/oauth/authorize?client_id=dbee0b940a5d97bab2b5&scope=user';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GitHub Sign In'),
      ),
      body: _buildWebView(),
    );
  }

  Widget _buildWebView() {
    return WebView(
      initialUrl: authorizationUrl,
      javascriptMode: JavascriptMode.unrestricted,
      navigationDelegate: (NavigationRequest request) {
        if (request.url.startsWith(redirectUri)) {
          // Extract code from the callback URL
          Uri uri = Uri.parse(request.url);
          String code = uri.queryParameters['code'] ?? '';
          _handleGitHubCallback(context, code);
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
    );
  }

    void _handleGitHubCallback(String code) {
    // Implement code handling (send it to your server, etc.)
    // Once authenticated, you can navigate to the next screen
    Navigator.pop(context); // Close the GitHubSignInScreen
    // Navigate to the next screen or perform necessary actions
    }

}
