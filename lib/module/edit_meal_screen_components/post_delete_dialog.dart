import 'package:flutter/material.dart';
import 'package:flutter_miniproject/config/route.dart';

showConfirmationDialog(BuildContext context, String content) {
  Widget okButton = TextButton(
    child: Text('OK'),
    onPressed: () {
      //Navigator.of(context).pop();
      Navigator.popUntil(
          context,
          ModalRoute.withName(
              RouteGenerator.mealsRoute)); //TODO: palitan to later
    },
  );

  AlertDialog _alert = AlertDialog(
    title: Text('Meal Update'),
    content: Text(content),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return _alert;
    },
  );
}
