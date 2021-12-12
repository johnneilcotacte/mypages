import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_miniproject/model/ingredient.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_miniproject/model/ingredient.dart';
import 'package:flutter_miniproject/provider/recipe_provider.dart';
import 'package:flutter_miniproject/provider/const_provider.dart';

class RecipeListItem extends HookWidget {
  final String? ingredient;

  const RecipeListItem({
    Key? key,
    required this.ingredient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _recipeProvider = useProvider(recipeProvider);
    final _constants = useProvider(constantsProvider);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _constants.kDefaultPadding),
      child: Container(
          height: 50,
          margin: EdgeInsets.symmetric(vertical: 5),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: _constants.kDarkBlackColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ingredient!,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                  //Text(ingredient.date),
                ],
              ),
              IconButton(
                onPressed: () {
                  _recipeProvider.deleteIngredient(ingredient: ingredient!);
                },
                icon: Icon(Icons.delete),
              )
            ],
          )),
    );
  }
}
