import 'package:flutter/material.dart';

class InternetDialog extends StatelessWidget {
  // final String title;
  // final String content;
  final VoidCallback onClose;

  InternetDialog({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(20.0), // Juster værdien efter dit ønske.
      ),
      title: Text('Ingen internet'),
      content: Text(
          'Du bliver stadig logget ind, men\ndine visninger bliver ikke opdateret, eller rapporter uploadet,\nfør du får forbindelse igen.\nVil du fortsætte?'),
      actions: <Widget>[
        TextButton(
          child: Text('Nej'),
          onPressed: () {
            onClose();
            //  _formKey.currentState?.reset();
            Navigator.of(context).pop(); // Luk dialogen.
          },
        ),
        TextButton(
          child: Text('Ja'),
          onPressed: () {
            // Navigator.of(context).pop(); // Luk dialogen.
            Navigator.of(context).pop();

            Navigator.pushReplacementNamed(context, '/mainPage');
          },
        ),
      ],
    );
  }
}
