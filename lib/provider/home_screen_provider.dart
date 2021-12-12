// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter_miniproject/api/CRUD_meal_api.dart';
import 'package:flutter_miniproject/api/auth.dart';
import 'package:flutter_miniproject/api/home_screen_api.dart';
import 'package:flutter_miniproject/model/macronutrient.dart';
import 'package:flutter_miniproject/model/meal.dart';
import 'package:flutter_miniproject/provider/home_screen_api_provider.dart';
import 'package:flutter_miniproject/provider/meal_api_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final homescreenProvider = ChangeNotifierProvider<HomeScreenNotifier>((ref) {
  final homescreen = ref.watch(initialhomescreenProvider).homescreen;
  return HomeScreenNotifier(homescreen: homescreen);
});

class HomeScreenNotifier extends ChangeNotifier {
  HomeScreenAPI homescreen;
  List<Meal?> mealsEveryday = [];
  MacroNutrient? nutrients;
  HomeScreenNotifier({required this.homescreen});

  Future<void> getEverydayMeals(
      {required String date,
      required String user_id,
      required String access_token}) async {
    mealsEveryday = await homescreen.getEverydayMeal(
        date: date, user_id: user_id, access_token: access_token);
    notifyListeners();
  }

  Future<void> addMeals(
      {required String date,
      required String user_id,
      required String access_token}) async {
    nutrients = await homescreen.getNutrients(
        date: date, user_id: user_id, access_token: access_token);
  }
}
