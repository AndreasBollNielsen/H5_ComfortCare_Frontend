import 'package:flutter/material.dart';
import '../pages/LoginPage.dart'; // Import your LoginPage or use the appropriate path
import 'LogoutDialog.dart';
import '../Services/AuthenticationService.dart';

class MainPageContent extends StatelessWidget {
  final Widget content;
  final bool showBackButton;
  final bool isLoggedIn;
  final String title;
  final AuthService? authorizationService;

  MainPageContent(
      {required this.content,
      this.showBackButton = false,
      this.isLoggedIn = false,
      required this.title,
      this.authorizationService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Align(
              alignment: Alignment.centerLeft,
              child: isLoggedIn
                  ? IconButton(
                      icon: Icon(Icons.exit_to_app),
                      onPressed: () => showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return LogoutDialog(
                                authService: authorizationService!,
                              );
                            },
                          ))
                  : null)
        ],
        title: Text(title),
        centerTitle: true,
        leading: showBackButton
            ? BackButton(onPressed: () {
                Navigator.pop(context);
              })
            : null,
      ),
      body: content,
    );
  }
}
