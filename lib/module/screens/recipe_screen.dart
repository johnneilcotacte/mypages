import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:flutter_miniproject/model/meal.dart';

import 'package:flutter_miniproject/config/route.dart';

import 'package:flutter_miniproject/model/screen_argument.dart';
import 'package:flutter_miniproject/provider/const_provider.dart';
import 'package:flutter_miniproject/provider/meal_provider.dart';
import 'package:flutter_miniproject/responsive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RecipePage extends HookWidget {
  const RecipePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    final _isLoading = useState(false);
    final _mealProvider = useProvider(mealProvider);

    _loadMeals() async {
      _isLoading.value = true;

      try {
        // await _mealProvider.getMeals();
      } on Exception catch (error) {
        print(error);
      }
      _isLoading.value = false;
    }

    useEffect(() {
      _loadMeals();
      return;
    }, []);

    final listMeals = _mealProvider.mealList;

    final _const = useProvider(constantsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_alert),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(50.0),
        child: Responsive.isDesktop(context)
            ? CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(15, 0.0, 7.5, 0.0),
                            height: 500.0,
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(20.0),
                            ),
                            child: RecipeItemCard(args),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(7.5, 0.0, 15.0, 0.0),
                            height: 500.0,
                            decoration: new BoxDecoration(
                              border: Border.all(
                                  width: 3.0, color: _const.kBodyTextColor),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: RecipeListCard(args),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 7.5),
                            width: 500.0,
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(20.0),
                            ),
                            child: RecipeItemCard(args),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0.0, 7.5, 0.0, 15.0),
                            width: 500.0,
                            decoration: new BoxDecoration(
                              border: Border.all(
                                  width: 3.0, color: _const.kBodyTextColor),
                              borderRadius: BorderRadius.circular(20),
                              // boxShadow: [
                              //   BoxShadow(
                              //       color: Colors.grey.withOpacity(0.3),
                              //       offset: Offset(-10.0, 10.0),
                              //       blurRadius: 100.0,
                              //       spreadRadius: 4.0),
                              // ],
                            ),
                            child: RecipeListCard(args),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class RecipeItemCard extends HookWidget {
  const RecipeItemCard(this.args, {Key? key}) : super(key: key);
  final ScreenArguments args;

  @override
  Widget build(BuildContext context) {
    final _const = useProvider(constantsProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          child: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                args.meal!.image!,
                height: 500,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ),
        Text(args.meal!.name!,
            style: TextStyle(
                decoration: TextDecoration.none,
                fontFamily: _const.kPoppins,
                color: _const.kBodyTextColor,
                fontSize: 40.0,
                fontWeight: FontWeight.w500)),
      ],
    );
  }
}

class RecipeListCard extends HookWidget {
  RecipeListCard(this.args, {Key? key}) : super(key: key);
  final List<String> sample = ['hello', 'world'];
  final ScreenArguments args;

  @override
  Widget build(BuildContext context) {
    final _mealProvider = useProvider(mealProvider);
    // final Meal meal;
    // List<Ingredient> ingredients = _mealProvider.mealList.recipes;

    return Container(
      width: 300,
      height: 100,
      child: ListView.builder(
        itemCount: args.meal!.ingredients!.length,
        // _mealProvider.mealList[i].recipes!.length,
        itemBuilder: (context, i) {
          return ListTile(
            leading: Checkbox(
              checkColor: Colors.white,
              // fillColor: MaterialStateProperty.resolveWith(getColor),
              value: true,
              onChanged: (bool? value) {},
            ),
            title: Text(args.meal!.ingredients![i]!),
          );
        },
      ),
    );
  }
}
