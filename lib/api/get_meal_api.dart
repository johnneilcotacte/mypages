import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_miniproject/model/meal.dart';
import 'package:flutter_miniproject/model/ingredient.dart';
import 'package:http/http.dart' as http;

class AllMealsAPI {
  Future<List<Meal>> getAll({required int page}) async {
    try {
      var url = Uri.parse(
          '"https://api.instantwebtools.net/v1/passenger?page=$page&size=10"');
      var response = await http.get(
        url,
      );
      Map<String, dynamic> dataResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final meals = dataResponse['data']
            .map<Meal>((data) => Meal.fromJson(data as Map<String, dynamic>))
            .toList() as List<Meal>;
        return meals;

        //totalPages = result.totalPages;

      } else {
        return [];
      }
    } catch (er) {
      throw Exception(er);
    }
  }

  Future<List<Meal>> getPerCategory(
      {required int page, required String category}) async {
    try {
      var url = Uri.parse(
          '"https://api.instantwebtools.net/v1/passenger?page=$page&size=10&$category"');
      var response = await http.get(
        url,
      );
      Map<String, dynamic> dataResponse = jsonDecode(response.body);
      if (response.statusCode == 201) {
        final meals = dataResponse['data']
            .map<Meal>((data) => Meal.fromJson(data as Map<String, dynamic>))
            .toList() as List<Meal>;
        return meals;

        //totalPages = result.totalPages;

      } else {
        return [];
      }
    } catch (er) {
      throw Exception(er);
    }
  }
}
