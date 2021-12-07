import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_miniproject/model/meal.dart';
import 'package:flutter_miniproject/model/ingredient.dart';
import 'package:http/http.dart' as http;

class AuthAPI {
  String _meal_uri = '';

  Future<bool> logInUser(
      {required String email, required String password}) async {
    try {
      var url = Uri.parse('https://reqres.in/api/login');
      var response = await http.post(
        url,
        body: {
          "email": "$email",
          "password": "$password",
        },
      );

      if (response.statusCode == 200) {
        // print(response.body);
        return true;
      } else {
        // print('invalid');
        return false;
      }
    } catch (er) {
      throw Exception(er);
    }
  }

  Future<bool> createUser({
    required String username,
    required String password,
    required String firstname,
    required String lastname,
    required String email,
    required String age,
  }) async {
    try {
      var url = Uri.parse('https://example.com/whatsit/create');
      var response = await http.post(
        url,
        body: {
          "username": "$username",
          "password": "$password",
          "first_name": "$firstname",
          "last_name": "$lastname",
          "email": "$email",
          "age": "$age"
        },
      );
      if (response.statusCode == 200) {
        //print(response.body);
        return true;
      } else {
        //print('invalid');
        return false;
      }
    } catch (er) {
      throw Exception(er);
    }
  }
}


class InitialDummyMeals {
  // Future<List<Meal>> initializeListBlog() async {
  //   Uint8List? _image0 = (await rootBundle.load('assets/images/hotdog.png'))
  //       .buffer
  //       .asUint8List();
  //   Uint8List? _image1 = (await rootBundle.load('assets/images/lechon.jpg'))
  //       .buffer
  //       .asUint8List();
  //   Uint8List? _image2 = (await rootBundle.load('assets/images/paksiw.jpg'))
  //       .buffer
  //       .asUint8List();

  //   return [
  //     Meal(id: '1', name: 'hotdog', image: _image1, recipes: [
  //       Ingredient(id: 'b1', name: 'hotdog', isBought: false),
  //     ]),
  //     Meal(id: '2', name: 'Lechon', image: _image0, recipes: [
  //       Ingredient(id: 'a1', name: 'pig', isBought: true),
  //       Ingredient(id: 'a2', name: 'bawang', isBought: true),
  //       Ingredient(id: 'a3', name: 'MSG', isBought: true),
  //     ]),
  //     Meal(id: '3', name: 'Lechon Paksiw', image: _image2, recipes: [
  //       Ingredient(id: 'c1', name: 'lechon', isBought: true),
  //       Ingredient(id: 'c2', name: 'tuyo', isBought: false),
  //     ]),
  //   ];
  // }
}
