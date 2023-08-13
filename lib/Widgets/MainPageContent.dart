import 'package:flutter/material.dart';
import '../pages/LoginPage.dart'; // Import your LoginPage or use the appropriate path

class MainPageContent extends StatelessWidget {
  final Widget content;
  final bool showBackButton;
  final bool isLoggedIn;
  final String title;

  MainPageContent({
    required this.content,
    this.showBackButton = true,
    this.isLoggedIn = true,
    this.title = 'Comfort Care',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        // Other app bar settings...
      ),
      drawer: Drawer(
        // Drawer content...
      ),
      body: content,
    );
  }
}

