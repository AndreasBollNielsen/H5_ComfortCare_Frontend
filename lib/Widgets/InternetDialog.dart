import 'package:flutter/material.dart';

class InternetDialog extends StatelessWidget {
  final String title;
  // final String content;
  final VoidCallback onClose;

  InternetDialog({required this.onClose, required this.title});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: Text('$title'),
      content: Text(
          'Du bliver stadig logget ind, men\ndine visninger bliver ikke opdateret, eller rapporter uploadet,\nfør du får forbindelse igen til serveren.\nVil du fortsætte?'),
      actions: <Widget>[
        TextButton(
          child: Text('Nej'),
          onPressed: () {
            onClose();

            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Ja'),
          onPressed: () {
            Navigator.of(context).pop();

            Navigator.pushReplacementNamed(context, '/mainPage');
          },
        ),
      ],
    );
  }
}
