// import 'dart:typed_data';
// import 'package:flutter_miniproject/model/ingredient.dart';

// class Meal {
//   String? _id;
//   String? _name;
//   Uint8List? _image;
//   List<Ingredient>? _recipes = [];

//   Meal({
//     String? id,
//     String? name,
//     Uint8List? image,
//     List<Ingredient>? recipes,
//   }) {
//     _id = id;
//     _name = name;
//     _image = image;
//     _recipes = recipes;
//   }
//   String? get id => _id;
//   String? get name => _name;
//   Uint8List? get image => _image;
//   List<Ingredient>? get recipes => _recipes;
// }

// ignore_for_file: non_constant_identifier_names

import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter_miniproject/model/ingredient.dart';

//https://medium.com/flutter-community/parsing-complex-json-in-flutter-747c46655f51
class Meal {
  String? _user_id;
  String? _id;
  String? _name;
  String? _image;
  String? _recipe = "take one and fry";
  List<String?>? _mealType;
  List<String?>? _ingredients;

  Meal({
    String? user_id,
    String? id,
    String? name,
    String? image,
    List<String?>? mealType,
    List<String?>? ingredients,
  }) {
    _id = id;
    _name = name;
    _image = image;
    _mealType = mealType;
    _ingredients = ingredients;
    _user_id = user_id;
  }

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        id: json['userId'],
        name: json['mealName'] as String? ?? '',
        image: json['mealImage'] as String? ?? '',
        mealType: json['mealType'] as List<String?>? ?? [],
        ingredients: json['ingredients'] as List<String?>? ?? [],
      );

  Map<String, dynamic> createtoJson() {
    return {
      "user_id": user_id,
      "mealName": name,
      "mealImage": image,
      "mealType": mealType,
      "ingredients": ingredients,
      "recipe": _recipe,
    };
  }

  Map<String, dynamic> updatetoJson() {
    return {
      "user_id": user_id,
      "id": id,
      "mealName": name,
      "mealImage": image,
      "mealType": mealType,
      "ingredients": ingredients,
      "recipe": _recipe,
    };
  }

  String? get user_id => _user_id;
  String? get id => _id;
  String? get name => _name;
  String? get image => _image;
  List<String?>? get mealType => _mealType;
  List<String?>? get ingredients => _ingredients;
}
