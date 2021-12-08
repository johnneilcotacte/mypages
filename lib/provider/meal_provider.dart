import 'package:flutter/cupertino.dart';
import 'package:flutter_miniproject/api/auth.dart';
import 'package:flutter_miniproject/model/meal.dart';
import 'package:flutter_miniproject/provider/meal_api_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final mealProvider = ChangeNotifierProvider<BlogsNotifier>((ref) {
  final initialdata = ref.watch(initialMealProvider).dummydata;
  return BlogsNotifier(meal: initialdata);
});

class BlogsNotifier extends ChangeNotifier {
  final InitialDummyMeals meal;

  List<Meal> _mealList = [];

  BlogsNotifier({
    required this.meal,
  });

  List<Meal> get mealList => _mealList;

  Future<List<Meal>> getMeals() async {
    // final data = await meal.initializeListBlog();

    //_mealList = data;

    return _mealList;
  }

  Future<void> addMeal({required Meal newmeal}) async {
    _mealList = [..._mealList, newmeal];

    notifyListeners();
  }

  Future<void> deleteMeal({required String id}) async {
    _mealList.removeWhere((everyblog) => everyblog.id == id);

    notifyListeners();
  }

  Future<void> updateMeal({required Meal updatedMeal}) async {
//https://stackoverflow.com/questions/56283870/how-to-update-a-single-item-in-flutter-list-as-a-best-way/60678253

    _mealList[_mealList.indexWhere(
        (everyblog) => everyblog.id == updatedMeal.id)] = updatedMeal;

    notifyListeners();
  }
}
