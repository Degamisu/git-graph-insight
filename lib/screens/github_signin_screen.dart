import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
    if (Platform.isLinux) {
        // Handle Linux differently or choose an alternative approach
        return Center(
        child: Text('GitHub Sign In is not supported on Linux.'),
        );
    } else {
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

            return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
        },
        );
    }
    }

  void _handleGitHubCallback() {
    if (_code != null) {
      // Now you can use the '_code' variable as needed

      Navigator.pop(context); // Close the GitHubSignInScreen
      // Navigate to the next screen or perform necessary actions
    }
  }

  @override
  void initState() {
    super.initState();
    _handleGitHubCallback();
  }
}

class GitHubSignInScreen extends StatefulWidget {
  final String authorizationUrl;
  final String redirectUri;

  GitHubSignInScreen({required this.authorizationUrl, required this.redirectUri});

  @override
  _GitHubSignInScreenState createState() => _GitHubSignInScreenState();
}