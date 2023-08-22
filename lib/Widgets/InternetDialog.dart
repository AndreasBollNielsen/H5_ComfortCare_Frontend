import 'package:flutter/material.dart';

class InternetDialog extends StatelessWidget {
  // final String title;
  // final String content;

  InternetDialog();

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
            //  _formKey.currentState?.reset();
            Navigator.of(context).pop(); // Luk dialogen.
          },
        ),
        TextButton(
          child: Text('Ja'),
          onPressed: () {
            // Navigator.of(context).pop(); // Luk dialogen.
            Navigator.pushReplacementNamed(context, '/mainPage');
          },
        ),
      ],
    );
  }
}
