import 'package:flutter/material.dart';

showInvalidDialog(BuildContext context) {
  // Create button
  Widget okButton = TextButton(
    child: Text('OK'),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog _alert = AlertDialog(
    title: Text('Meal Update'),
    content: Text('Incomplete data!'),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return _alert;
    },
  );
}
