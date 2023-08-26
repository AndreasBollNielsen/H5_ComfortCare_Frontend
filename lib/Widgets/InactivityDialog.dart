import 'package:flutter/material.dart';

class InactivityDialog extends StatelessWidget {
  InactivityDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: Text('Automatisk log ud'),
      content: Text(
          'Du har været væk i mere end 20 minutter,\n og er derfor logget ud'),
      actions: <Widget>[
        TextButton(
          child: Text('ok'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
