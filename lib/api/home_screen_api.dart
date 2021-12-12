// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter_miniproject/model/list_of_meal.dart';
import 'package:flutter_miniproject/model/macronutrient.dart';
import 'package:flutter_miniproject/model/meal.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HomeScreenAPI {
  String _url = 'https://wca-meal-planner.herokuapp.com/';

  Future<MacroNutrient?> getNutrients(
      {required String date,
      required String user_id,
      required String access_token}) async {
    try {
      var url = Uri.parse(_url + '');
      var response = await http.get(url,
          headers: {'user_id': user_id, 'access_token': access_token});

      if (response.statusCode == 201) {
        return MacroNutrient.fromJson(jsonDecode(response.body));
      } else {
        // print('invalid');
        return null;
      }
    } catch (er) {
      print(er);
      //throw Exception(er);
    }
  }

  Future<List<Meal?>> getEverydayMeal(
      {required String date,
      required String user_id,
      required String access_token}) async {
    try {
      var url = Uri.parse(_url + '');
      var response = await http.get(url,
          headers: {'user_id': user_id, 'access_token': access_token});

      if (response.statusCode == 201) {
        final result = mealsDataFromJson(response.body);
        return result.data;
      } else {
        return [];
      }
    } catch (er) {
      return [];
    }
  }
}
