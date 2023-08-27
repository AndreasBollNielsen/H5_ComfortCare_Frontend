import 'package:flutter/material.dart';
import 'package:flutter_comfortcare/Services/InactivityService.dart';
import '../Services/AuthenticationService.dart';

class LogoutDialog extends StatelessWidget {
  final AuthService authService;
  final AutoLogoutService inactivityService;

  LogoutDialog({required this.authService, required this.inactivityService});

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
            inactivityService.ResetTimer();
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Ja'),
          onPressed: () {
            //set login bool
            inactivityService.StopTimer();
            authService.Logout(context);
          },
        ),
      ],
    );
  }
}
