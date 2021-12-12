import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_miniproject/provider/const_provider.dart';

class CustomTextField extends HookWidget {
  final TextEditingController controller;
  final double fontsize;
  final String labelText;
  final FontWeight? fontweight;
  final double? height;
  final int? minlines;
  CustomTextField(
      {Key? key,
      required this.controller,
      required this.fontsize,
      required this.labelText,
      this.fontweight,
      this.height,
      this.minlines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _constants = useProvider(constantsProvider);
    return TextField(
      style: TextStyle(
        fontSize: fontsize,
        fontFamily: "Raleway",
        color: _constants.kDarkBlackColor,
        height: height,
        fontWeight: fontweight,
      ),
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: labelText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _constants.kDarkBlackColor, width: 1),
        ),
      ),
      keyboardType: TextInputType.multiline,
      maxLines: null,
      minLines: minlines,
    );
  }
}
