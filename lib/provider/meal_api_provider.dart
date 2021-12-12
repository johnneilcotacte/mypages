// import 'package:flutter_miniproject/api/auth.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// final initialMealProvider = Provider<FakeMealAPI>((ref) {
//   return FakeMealAPI();
// });

// class FakeMealAPI {
//   final dummydata = InitialDummyMeals();
// }

import 'package:flutter_miniproject/api/CRUD_meal_api.dart';
import 'package:flutter_miniproject/api/auth.dart';
import 'package:flutter_miniproject/model/meal.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final initialmealProvider = Provider<MealProvider>((ref) {
  return MealProvider();
});

class MealProvider {
  final meal = CRUD();
}
