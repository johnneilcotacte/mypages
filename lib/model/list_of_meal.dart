import 'dart:convert';

import 'package:flutter_miniproject/model/meal.dart';

// https://github.com/themaaz32/infinite_list_pagination.git
MealsData mealsDataFromJson(String str) => MealsData.fromJson(json.decode(str));

//String passengersDataToJson(MealsData data) => json.encode(data.toJson());

class MealsData {
  MealsData({
    required this.totalMeals,
    required this.totalPages,
    required this.data,
  });

  int totalMeals;
  int totalPages;
  List<Meal> data;

  factory MealsData.fromJson(Map<String, dynamic> json) => MealsData(
        totalMeals: json["totalMeals"], //change this
        totalPages: json["totalPages"],
        data: List<Meal>.from(json["data"].map((x) => Meal.fromJson(x))),
      );
}
