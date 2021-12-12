import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SnackBarErrorMessage extends HookWidget {
  final String text;
  SnackBarErrorMessage({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(text),
      action: SnackBarAction(
        label: 'Dismiss',
        onPressed: () {},
      ),
    );
  }
}
