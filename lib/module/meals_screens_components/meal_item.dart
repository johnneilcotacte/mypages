import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_miniproject/model/meal.dart';
import 'package:flutter_miniproject/model/screen_argument.dart';
import 'package:flutter_miniproject/module/screens/recipe_screen.dart';
import 'package:flutter_miniproject/config/route.dart';

class MealItem extends HookWidget {
  final Meal meal;

  const MealItem({
    required this.meal,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //TODO: Change this to pop with data for ChangeMealScreen, add ternary operator
        Navigator.pushNamed(context, '${RouteGenerator.recipepageRoute}',
            arguments: ScreenArguments(meal));
      },
      child: GridTile(
        child: Image.network(meal.image!, fit: BoxFit.cover),
        // child: FittedBox(
        //   fit: BoxFit.fill,
        //   child: Container(
        //     width: 150,
        //     height: 180,
        //     decoration: BoxDecoration(
        //       image: DecorationImage(image: NetworkImage(meal.image!)),
        //       //color: Colors.grey.shade200,
        //     ),
        //   ),
        // ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(
            meal.name!,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
