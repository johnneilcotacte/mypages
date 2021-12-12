import 'package:flutter/material.dart';
import 'package:flutter_miniproject/module/screens/create_meal_screen.dart';
import 'package:flutter_miniproject/module/screens/edit_meal_screen.dart';
import 'package:flutter_miniproject/module/screens/homes_screen.dart';
import 'package:flutter_miniproject/module/screens/authentication_screen.dart';
import 'package:flutter_miniproject/module/screens/all_meals_screen.dart';
import 'package:flutter_miniproject/module/screens/user_screen.dart';
import 'package:flutter_miniproject/module/screens/recipe_screen.dart';

class RouteGenerator {
  static const String loginRoute = '/mealplanner';
  static const String homeRoute = '/mealplanner/home';
  static const String mealsRoute = '/mealplanner/meals';
  static const String createmealRoute = '/mealplanner/meals/createmeal';
  static const String recipepageRoute = '/mealplanner/meals/recipepage';
  static const String editmealRoute = '/mealplanner/meals/editmeal';
  static const String useraccountRoute = '/mealplanner/useraccount';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(
          builder: (context) => _RouteHandler(routeWidget: LoginPage()),
          settings: settings,
        );
      case homeRoute:
        return MaterialPageRoute(
          builder: (context) => _RouteHandler(routeWidget: HomePage()),
          settings: settings,
        );
      case mealsRoute:
        return MaterialPageRoute(
          builder: (context) => _RouteHandler(routeWidget: AllMealsPage()),
          settings: settings,
        );

      case createmealRoute:
        return MaterialPageRoute(
          builder: (context) => _RouteHandler(routeWidget: CreateMealPage()),
          settings: settings,
        );

      case recipepageRoute:
        return MaterialPageRoute(
          builder: (context) => _RouteHandler(routeWidget: RecipePage()),
          settings: settings,
        );
      case editmealRoute:
        return MaterialPageRoute(
          builder: (context) => _RouteHandler(routeWidget: EditMealPage()),
          settings: settings,
        );
      case useraccountRoute:
        return MaterialPageRoute(
          builder: (context) => _RouteHandler(routeWidget: UserPage()),
          settings: settings,
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
        builder: (context) => Scaffold(
            appBar: AppBar(title: Text('Error')),
            body: Center(
              child: Text('Page not found!'),
            )));
  }
}

class _RouteHandler extends StatelessWidget {
  final Widget routeWidget;

  const _RouteHandler({Key? key, required this.routeWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return routeWidget;
  }
}
