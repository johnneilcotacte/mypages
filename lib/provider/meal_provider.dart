// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter_miniproject/api/CRUD_meal_api.dart';
import 'package:flutter_miniproject/api/auth.dart';
import 'package:flutter_miniproject/model/meal.dart';
import 'package:flutter_miniproject/provider/meal_api_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final mealProvider = ChangeNotifierProvider<MealsNotifier>((ref) {
  final meal = ref.watch(initialmealProvider).meal;
  return MealsNotifier(crud: meal);
});

class MealsNotifier extends ChangeNotifier {
  CRUD crud;
  MealsNotifier({required this.crud});
  List<int> mealList = [];
  List<int> breakfast = [];
  List<int> lunch = [];
  List<int> dinner = [];
  List<int> search = [];

  // List<int> get breakfast => mealList;
  // List<int> get lunch => lunch;
  // List<int> get dinner => dinner;
  // List<int> get search => search;
  int getTotalMeals() {
    return crud.page;
  }

  Future<List<int>> searchMeals(
      {required String query,
      required String user_id,
      required String access_token}) async {
    // final data = await crud.searchMeal(
    //     user_id: user_id, access_token: access_token, query: query);
    final data = [1, 2, 3, 4];
    if (data.isNotEmpty) {
      mealList = data;
    }

    return search;
  }

  //gawin nyu na future
  Future<List<int>> getMeals(
      {required int page,
      required String user_id,
      required String access_token,
      required String mealType}) async {
    // final data = await crud.getMeals(
    //     user_id: user_id,
    //     access_token: access_token,
    //     page: page,
    //     mealType: mealType);
    final data = [1, 2, 3, 4];
    if (mealType == 'breakfast') {
      if (breakfast.isNotEmpty && data.isNotEmpty) {
        breakfast = [
          ...breakfast,
          // ...data,
          ...[5, 6, 7, 8]
        ];
      } else if (breakfast.isEmpty && data.isNotEmpty) {
        // breakfast = data;
        breakfast = [5, 6, 7, 8];
      }
      return breakfast;
    }
    if (mealType == 'lunch') {
      if (lunch.isNotEmpty && data.isNotEmpty) {
        lunch = [
          ...lunch,
          // ...data,
          ...[9, 10, 11, 12]
        ];
      } else if (lunch.isEmpty && data.isNotEmpty) {
        //lunch = data;
        lunch = [9, 10, 11, 12];
      }
      return lunch;
    }
    if (mealType == 'dinner') {
      if (dinner.isNotEmpty && data.isNotEmpty) {
        dinner = [
          ...dinner,
          //...data,
          ...[13, 14, 15, 16]
        ];
      } else if (dinner.isEmpty && data.isNotEmpty) {
        //dinner = data;
        dinner = [13, 14, 15, 16];
      }
      return dinner;
    } else {
      if (mealList.isNotEmpty && data.isNotEmpty) {
        mealList = [
          ...mealList,
          //...data,
          ...[1, 2, 3, 4, 5, 6, 7, 8, 9]
        ];
      } else if (mealList.isEmpty && data.isNotEmpty) {
        // mealList = data;
        mealList = [1, 2, 3, 4, 5, 6, 7, 8, 9];
      }
      return mealList;
    }
  }

  Future<void> addMeals(
      {required Map<String, dynamic> newMeal,
      required String user_id,
      required String access_token}) async {
    // final data = await crud.createMeal(
    //     newMeal: newMeal, user_id: user_id, access_token: access_token);

    final data = 55555555;
    mealList = [...mealList, data];

    notifyListeners();
  }

//   Future<void> deleteMeal({required String id}) async {
//     mealList.removeWhere((everyblog) => everyblog.id == id);

//     notifyListeners();
//   }

//   Future<void> updateMeal({required Meal updatedMeal}) async {
// //https://stackoverflow.com/questions/56283870/how-to-update-a-single-item-in-flutter-list-as-a-best-way/60678253

//     mealList[mealList.indexWhere(
//         (everyblog) => everyblog.id == updatedMeal.id)] = updatedMeal;

//     notifyListeners();
//   }
}
