// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter_miniproject/model/list_of_meal.dart';
import 'package:flutter_miniproject/model/meal.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

//https://www.youtube.com/watch?v=KcRtURq-Ww8&t=820s
class CRUD {
  String _url = 'https://wca-meal-planner.herokuapp.com/';
  int _page = 0;
  int get page => _page;
  Future<Meal?> createMeal(
      {required Map<String, dynamic> newMeal,
      required String user_id,
      required String access_token}) async {
    try {
      var url = Uri.parse(_url + 'meals/add');
      var response = await http.post(url,
          body: newMeal,
          headers: {'user_id': user_id, 'access_token': access_token});

      if (response.statusCode == 200) {
        return Meal.fromJson(jsonDecode(response.body));
      } else {
        // print('invalid');
        return null;
      }
    } catch (er) {
      print(er);
      //throw Exception(er);
    }
  }

  Future<Response?> updateMeal(
      {required Map<String, dynamic> newMeal,
      required String user_id,
      required String access_token}) async {
    try {
      var url = Uri.parse(_url + '');
      var response = await http.patch(url,
          body: newMeal,
          headers: {'user_id': user_id, 'access_token': access_token});

      if (response.statusCode == 200) {
        // print(response.body);
        return response;
      } else {
        // print('invalid');
        return response;
      }
    } catch (er) {
      throw Exception(er);
    }
  }

  Future<Response?> deleteMeal(
      {required Map<String, dynamic> newMeal,
      required String user_id,
      required String access_token}) async {
    try {
      var url = Uri.parse(_url + '');
      var response = await http.delete(url,
          body: newMeal,
          headers: {'user_id': user_id, 'access_token': access_token});

      if (response.statusCode == 200) {
        // print(response.body);
        return response;
      } else {
        // print('invalid');
        return response;
      }
    } catch (er) {
      throw Exception(er);
    }
  }

  Future<List<Meal>> getMeals({
    required int page,
    required String user_id,
    required String access_token,
    required String mealType,
  }) async {
    try {
      var url = Uri.parse(_url + '');
      var response = await http.get(url,
          headers: {'user_id': user_id, 'access_token': access_token});

      if (response.statusCode == 200) {
        final result = mealsDataFromJson(response.body);
        _page = result.totalPages;
        return result.data;
        // print(response.body);

      } else {
        // print('invalid');
        return [];
      }
    } catch (er) {
      return [];
      //throw Exception(er);
    }
  }

  Future<List<Meal>> searchMeal(
      {required String query,
      required String user_id,
      required String access_token}) async {
    try {
      var url = Uri.parse(_url + '');
      var response = await http.get(url,
          headers: {'user_id': user_id, 'access_token': access_token});

      if (response.statusCode == 200) {
        final result = mealsDataFromJson(response.body);

        return result.data;
        // print(response.body);

      } else {
        // print('invalid');
        return [];
      }
    } catch (er) {
      return [];
      //throw Exception(er);
    }
  }
}
