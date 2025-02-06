import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  
  static const String githubUrl = 'https://github.com/mxg-mega/HNG-Mobile-Desktop';
  static const String hngHireUrl = 'https://hng12.slack.com/archives/C088PK3KE2K/p1738110526317749';

  static const String githubIcon = "assets/images/github.png";
  static const String slackIcon = "assets/images/slack.png";

  Future<void> launchURL(BuildContext context, String url) async {
    try {
      final Uri parsedUrl = Uri.parse(url);
      if (!await launchUrl(parsedUrl, mode: LaunchMode.inAppBrowserView)) {
        _showError(context, "Could not launch URL");
      }
    } catch (e) {
      _showError(context, "An error occurred while opening the link");
    }
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget _button({
    required BuildContext context,
    required String url,
    required String buttonTitle,
    required String logo,
  }) {
    return OutlinedButton.icon(
      icon: Image.asset(logo, width: 20),
      onPressed: () => launchURL(context, url),
      label: Text(buttonTitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("To open the GitHub page for this project"),
            _button(
              context: context,
              logo: githubIcon,
              buttonTitle: "Open GitHub Repo",
              url: githubUrl,
            ),
            const SizedBox(height: 7),
            const Text("To Hire Developer visit:"),
            _button(
              context: context,
              logo: slackIcon,
              buttonTitle: "HNG Hire Page - Flutter Developers",
              url: hngHireUrl,
            ),
          ],
        ),
      ),
    );
  }
}
