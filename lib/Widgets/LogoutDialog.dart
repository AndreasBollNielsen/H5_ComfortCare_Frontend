import 'package:flutter/material.dart';
import '../Services/AuthenticationService.dart';

class LogoutDialog extends StatelessWidget {
  final AuthService authService;

  LogoutDialog({required this.authService});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: Text('Log ud'),
      content: Text('Er du sikker på du vil logge ud af applikationen?'),
      actions: <Widget>[
        TextButton(
          child: Text('Nej'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Ja'),
          onPressed: () {
            //set login bool
            authService.Logout();

            //pop all stacks until first route
            Navigator.of(context).popUntil((route) => route.isFirst);
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
      ],
    );
  }
}
