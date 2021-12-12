import 'package:flutter/material.dart';
import 'package:flutter_miniproject/config/route.dart';

showMessageDialog(
    BuildContext context, String content, String title, bool status) {
  // Create button
  Widget okButton = TextButton(
    child: Text('OK'),
    onPressed: () {
      if (!status) {
        Navigator.of(context).pop();
      } else {
        Navigator.of(context).pushReplacementNamed(RouteGenerator.loginRoute);
      }
    },
  );

  // Create AlertDialog
  AlertDialog _alert = AlertDialog(
    title: Text(title),
    content: Text(content),
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
