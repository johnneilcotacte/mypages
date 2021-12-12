import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final showEmailProvider = ChangeNotifierProvider<ShowEmail>((ref) {
  return ShowEmail();
});

class ShowEmail extends ChangeNotifier {
  String initialEmailDisplay = '';

  void getEmail(String email) {
    initialEmailDisplay = email;
    notifyListeners();
  }
}
