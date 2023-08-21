import 'package:flutter/material.dart';

class InactivityDialog extends StatelessWidget {
  // final String title;
  // final String content;

  InactivityDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(20.0), // Juster værdien efter dit ønske.
      ),
      title: Text('Automatisk log ud'),
      content: Text(
          'Du har været væk i mere end 20 minutter,\n og er derfor logget ud'),
      actions: <Widget>[
        TextButton(
          child: Text('ok'),
          onPressed: () {
            // Navigator.of(context).pop(); // Luk dialogen.
            Navigator.pushReplacementNamed(context, '/mainPage');
          },
        ),
      ],
    );
  }
}
