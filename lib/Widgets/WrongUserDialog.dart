import 'package:flutter/material.dart';

class WrongUserDialog extends StatelessWidget {
  final String content;

  WrongUserDialog({required this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: Text('Forkert bruger login'),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          child: Text('ok'),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
      ],
    );
  }
}
