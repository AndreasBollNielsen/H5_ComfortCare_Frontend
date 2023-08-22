import 'package:flutter/material.dart';

class WrongUserDialog extends StatelessWidget {
  // final String title;
  final String content;

  WrongUserDialog({required this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(20.0), // Juster værdien efter dit ønske.
      ),
      title: Text('Forkert bruger login'),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          child: Text('ok'),
          onPressed: () {
            // Navigator.of(context).pop(); // Luk dialogen.
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
      ],
    );
  }
}
