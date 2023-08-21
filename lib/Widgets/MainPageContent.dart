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
      this.isLoggedIn = true,
      required this.title,
      this.authorizationService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Align(
              alignment: Alignment.centerLeft,
              child: showBackButton
                  ? IconButton(
                      icon: Icon(Icons.exit_to_app),
                      onPressed: () =>
                          // Navigator.pushReplacementNamed(context, '/login'),
                          showDialog(
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
            ? BackButton(
                onPressed: () {
                  final currentRouteName =
                      ModalRoute.of(context)?.settings.name;

                  if (currentRouteName == '/daySchedule') {
                    Navigator.pop(context);
                  } else if (currentRouteName == '/dayTask') {
                    Navigator.pop(context);
                  } else {
                    Navigator.pushReplacementNamed(context, '/login');
                  }
                },
              )
            : null,
        // Other app bar settings...
      ),
      body: content,
    );
  }
}
