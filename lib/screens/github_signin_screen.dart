import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GitHubSignInScreen extends StatefulWidget {
  final String authorizationUrl;
  final String redirectUri;

  GitHubSignInScreen(
      {required this.authorizationUrl, required this.redirectUri});

  @override
  _GitHubSignInScreenState createState() => _GitHubSignInScreenState();
}

class _GitHubSignInScreenState extends State<GitHubSignInScreen> {
  String? _code;

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
    if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
      // Handle Linux, Windows, or MacOS differently or choose an alternative approach
      return Center(
        child: Text('GitHub Sign In is not supported on this platform.'),
      );
    } else {
      return _getWebView();
    }
  }

  Widget _getWebView() {
    return WebView(
      initialUrl: widget.authorizationUrl,
      javascriptMode: JavascriptMode.unrestricted,
      navigationDelegate: (NavigationRequest request) {
        if (request.url.startsWith(widget.redirectUri)) {
          Uri uri = Uri.parse(request.url);
          String code = uri.queryParameters['code'] ?? '';

          setState(() {
            _code = code;
          });

          // Perform an action with _code, e.g., navigate to another screen
          if (_code != null) {
            _handleGitHubCallback();
          }

          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
    );
  }

  void _handleGitHubCallback() {
    if (_code != null) {
      // Now you can use the '_code' variable as needed

      Navigator.pop(
          context, _code); // Close the GitHubSignInScreen and pass _code
      // Navigate to the next screen or perform necessary actions
    }
  }

  @override
  void initState() {
    super.initState();
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authorizationUrl = 'https://github.com/login/oauth/authorize';
    final redirectUri = 'https://your-app-callback-url.com';

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => GitHubSignInScreen(
                  authorizationUrl: authorizationUrl,
                  redirectUri: redirectUri,
                ),
              ),
            );

            if (result != null) {
              // Handle the result from GitHubSignInScreen
              print('Sign-in successful with code: $result');
            }
          },
          child: Text('Sign in with GitHub'),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'GitHub Sign In Demo',
    home: HomeScreen(),
  ));
}
