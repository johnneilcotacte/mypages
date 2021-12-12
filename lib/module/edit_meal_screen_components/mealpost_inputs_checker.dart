import 'dart:typed_data';

import 'package:flutter_miniproject/model/meal.dart';

class MealPostChecker {
  static bool isComplete({
    // required String id,
    required String name,
    required List<String?> ingredients,
    required Uint8List? image,
  }) {
    if (name != '' &&
            ingredients != [] &&
            image != null //TODO: uncomment this later
        ) {
      return true;
    }
    return false;
  }
}
