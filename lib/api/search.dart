import 'dart:async';
import 'dart:convert';

import 'package:flutter_miniproject/model/meal.dart';
import 'package:http/http.dart' as http;



class SearchAPI {
  String _meal_uri = '';
  //https://github.com/JohannesMilke/filter_listview_example/blob/master/lib/page/filter_network_list_page.dart

  //https://www.youtube.com/watch?v=oFZIwBudIj0&list=WL&index=1&t=437s
    Future<List<Meal>> getMeals(String query) async {
    final url = Uri.parse(
        'https://gist.githubusercontent.com/JohannesMilke/d53fbbe9a1b7e7ca2645db13b995dc6f/raw/eace0e20f86cdde3352b2d92f699b6e9dedd8c70/meal.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List meal = json.decode(response.body);

      return meal.map((json) => Meal.fromJson(json)).where((meal) {
        final titleLower = meal.name!.toLowerCase();
      //  final authorLower = meal.author.toLowerCase();
        final searchLower = query.toLowerCase();

        return titleLower.contains(searchLower);
         //   authorLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  
}
