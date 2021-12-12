import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final constantsProvider = Provider<Constants>((ref) {
  return Constants();
});

class Constants {
  final _kPrimaryColor = Color(0xFFFF3B1D);
  final _kDarkBlackColor = Color(0xFF191919);
  final _kBgColor = Color(0xFFE7E7E7);
  final _kBodyTextColor = Color(0xFF666666);
  final _kAquamarine = Color(0xFF73fbd3);
  final _kPink = Color(0xFFf896d8);
  final _kPurple = Color(0xFFCA7DF9);
  final _kLightViolet = Color(0xFF724CF9);
  final _kDarkViolet = Color(0xFF564592);
  final _kPoppins = 'Poppins';

  final _kDefaultPadding = 20.0;
  final _kMaxWidth = 1232.0;
  final _kDefaultDuration = Duration(milliseconds: 250);
  Color get kPrimaryColor => _kPrimaryColor;
  Color get kDarkBlackColor => _kDarkBlackColor;
  Color get kBgColor => _kBgColor;
  Color get kBodyTextColor => _kBodyTextColor;
  Color get kAquamarine => _kAquamarine;
  Color get kPink => _kPink;
  Color get kPurple => _kPurple;
  Color get kLightViolet => _kLightViolet;
  Color get kDarkViolet => _kDarkViolet;
  String get kPoppins => _kPoppins;
  double get kDefaultPadding => _kDefaultPadding;
  double get kMaxWidth => _kMaxWidth;
  Duration get kDefaultDuration => _kDefaultDuration;
}
