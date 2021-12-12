import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_miniproject/provider/meal_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_miniproject/config/route.dart';
import 'package:flutter_miniproject/model/screen_argument.dart';
import 'package:flutter_miniproject/model/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomDrawer extends HookWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _mealProvider = useProvider(mealProvider);
    final _user = useProvider(mealProvider);
    final _isLoading = useState(false);
    //TODO: palitan to ng totoong user data
    /*
    _loadMeals() async {
      _isLoading.value = true;

      try {
        await _mealProvider.getMeals();
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
    */
    var user = User(
      id: '1',
      firstName: 'John Neil',
      lastName: 'Cotacte',
      email: 'jncotacte@gmail.com',
    );
    return Container(
      width: 150,
      color: Colors.grey.shade700,
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 56.0,
              child: Center(
                child: Text(
                  'Meal Plan',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ),
            Divider(
              height: 1,
              thickness: 2.0,
              indent: 20,
              endIndent: 20,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10), //add constants here
              child: Container(
                height: 56,
                child: Center(
                  child: Text('Dashboard'),
                ),
              ),
            ),
            _CustomTextButton(
              func: () {},
              icon: FontAwesomeIcons.calendarWeek,
              label: 'Meal Planner',
            ),
            _CustomTextButton(
              func: () {
                Navigator.pushNamed(context, '${RouteGenerator.mealsRoute}',
                    arguments: ScreenArguments(null));
              },
              icon: FontAwesomeIcons.utensils,
              label: 'Meals',
            ),
            _CustomTextButton(
              func: () {},
              icon: FontAwesomeIcons.store,
              label: 'Restaurants',
            ),
            Expanded(
              child: Container(),
            ),
            _CustomTextButton(
              func: () {
                Navigator.pushNamed(
                    context, '${RouteGenerator.useraccountRoute}',
                    arguments: UserScreenArguments(user));
              },
              icon: FontAwesomeIcons.userCircle,
              label: 'User Account',
            ),
            _CustomTextButton(
              func: () {},
              icon: FontAwesomeIcons.signOutAlt,
              label: 'Logout',
            ),
          ],
        ),
        elevation: 0,
      ),
    );
  }
}

class _CustomTextButton extends HookWidget {
  final Function() func;
  final IconData icon;
  final String label;
  _CustomTextButton(
      {Key? key, required this.func, required this.icon, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      child: TextButton.icon(
          onPressed: func,
          icon: FaIcon(
            icon,
            color: Colors.black54,
            size: 14,
          ),
          label: Text(
            label,
            style: TextStyle(color: Colors.black),
          )),
    );
  }
}
