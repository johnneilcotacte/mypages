import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_miniproject/model/ingredient.dart';

final recipeProvider = ChangeNotifierProvider<RecipeNotifier>((ref) {
  return RecipeNotifier();
});

class RecipeNotifier extends ChangeNotifier {
  List<String?> _ingredients = [];
  List<String?> get ingredients => _ingredients;

  void addIngredient({required String body}) {
    final newRecipe = body;
    _ingredients = [..._ingredients, newRecipe];
    notifyListeners();
  }

  void deleteIngredient({required String ingredient}) {
    _ingredients.removeWhere((ing) => ing == ingredient);
    notifyListeners();
  }

  void deletePrevList() {
    _ingredients = [];
    notifyListeners();
  }

  void updateListIng(List<String?> listIng) {
    _ingredients = listIng;
    notifyListeners();
  }
}
