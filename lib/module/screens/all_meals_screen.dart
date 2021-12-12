import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_miniproject/config/route.dart';
import 'package:flutter_miniproject/model/screen_argument.dart';
import 'package:flutter_miniproject/provider/current_user_provider.dart';
//import 'package:flutter_miniproject/module/meals_screens_components/add_meal_widget.dart';
import 'package:flutter_miniproject/provider/meal_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_miniproject/module/meals_screens_components/meal_item.dart';
import 'package:flutter_miniproject/provider/const_provider.dart';
import 'package:flutter_miniproject/model/meal.dart';
import 'dart:async';

class AllMealsPage extends HookWidget {
  const AllMealsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _searchController = useTextEditingController();
    final _isLoading = useState(false);
    final _mealProvider = useProvider(mealProvider);
    final _user = useProvider(currentUserProvider);
    final _scrollController = useScrollController();
    final _category = useState<String>('');
    //List<Meal> searched = [];
    int page1 = 0;
    int page2 = 0;
    int page3 = 0;
    int page4 = 0;
    int page5 = 0;
    int maxpages = 40;
    Timer? debouncer;

    //final _index = useState(0);

    void debounce(
      VoidCallback callback, {
      Duration duration = const Duration(milliseconds: 2000),
    }) {
      if (debouncer != null) {
        debouncer!.cancel();
      }

      debouncer = Timer(duration, callback);
    }

    _searchBook(String query) async {
      try {
        await _mealProvider.searchMeals(
            query: _searchController.text,
            user_id: _user.user!.id!,
            access_token: _user.user!.access_token!);
        _isLoading.value = true;
      } on Exception catch (error) {
        print(error);
      }
      _isLoading.value = false;
    }

    int _checkGridStatus() {
      if (_category.value == '') {
        return _mealProvider.mealList.length;
      }
      if (_category.value == 'breakfast') {
        return _mealProvider.breakfast.length;
      }
      if (_category.value == 'lunch') {
        return _mealProvider.lunch.length;
      }
      if (_category.value == 'dinner') {
        return _mealProvider.dinner.length;
      } else
        return _mealProvider.search.length;
    }

    //async to
    _loadMeals() async {
      _isLoading.value = true;

      try {
        _mealProvider.getMeals(
            mealType: _category.value,
            page: (_category.value == '')
                ? page1
                : (_category.value == 'breakfast')
                    ? page2
                    : (_category.value == 'lunch')
                        ? page3
                        : (_category.value == 'dinner')
                            ? page4
                            : page5,
            user_id: _user.user!.id!,
            access_token: _user.user!.access_token!);
      } on Exception catch (error) {
        print(error);
      }
      _isLoading.value = false;
    }

    bool _isAllLoaded() {
      //  int maxitem = _mealProvider.getTotalMeals();
      maxpages = 5;

      if (_category.value == '') {
        if (page1 == maxpages) {
          return true;
        }
      }
      if (_category.value == 'breakfast') {
        if (page2 == maxpages) {
          return true;
        }
      }
      if (_category.value == 'lunch') {
        if (page3 == maxpages) {
          return true;
        }
      }
      if (_category.value == 'dinner') {
        if (page4 == maxpages) {
          return true;
        }
      }
      if (_category.value == 'search') {
        if (page5 == maxpages) {
          return true;
        }
      }
      return false;
    }

    useEffect(() {
      _loadMeals();
      if (_category.value == '') {
        page1++;
      }
      if (_category.value == 'breakfast') {
        page2++;
      }
      if (_category.value == 'lunch') {
        page3++;
      }
      if (_category.value == 'dinner') {
        page4++;
      }
      if (_category.value == 'search') {
        page5++;
      }
      return;
    }, []);
    useEffect(() {
      _scrollController.addListener(() {
        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent) {
          if (!_isAllLoaded()) {
            _loadMeals();
            if (_category.value == '') {
              page1++;
            }
            if (_category.value == 'breakfast') {
              page2++;
            }
            if (_category.value == 'lunch') {
              page3++;
            }
            if (_category.value == 'dinner') {
              page4++;
            }
            if (_category.value == 'search') {
              page5++;
            }
          }
        }
      });
    }, [_scrollController]);
//////////////////////////////////////////////
    return WillPopScope(
      onWillPop: () async {
        _mealProvider.mealList = [];
        _mealProvider.breakfast = [];
        _mealProvider.lunch = [];
        _mealProvider.dinner = [];
        _mealProvider.search = [];

        return true;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //TODO: Change Container Widget to SearchBarWidget
                Container(
                  constraints: BoxConstraints(minWidth: 200, maxWidth: 200),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black26),
                  ),
                  child: TextField(
                    controller: _searchController,

                    decoration: InputDecoration(
                      hintText: 'Search',
                      icon: IconButton(
                        icon: Icon(Icons.search),

                        onPressed: () {
                          _category.value = 'search';
                          _searchBook(_searchController.text);
                        },
                        // Icons.visibility_outlined,
                        color: Colors.blue,
                      ),
                    ),
                    //onChanged:_searchBook,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.pushNamed(
                        context, '${RouteGenerator.createmealRoute}',
                        arguments: ScreenArguments(null));
                  },
                  //color: Colors.blue
                ),
              ],
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    _category.value = '';
                  },
                  child: Text('ALL'),
                  style: TextButton.styleFrom(
                    primary:
                        (_category.value == '') ? Colors.blue : Colors.grey,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _category.value = 'breakfast';
                  },
                  child: Text('BREAKFAST'),
                  style: TextButton.styleFrom(
                    primary: (_category.value == 'breakfast')
                        ? Colors.blue
                        : Colors.grey,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _category.value = 'lunch';
                  },
                  child: Text('LUNCH'),
                  style: TextButton.styleFrom(
                    primary: (_category.value == 'lunch')
                        ? Colors.blue
                        : Colors.grey,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _category.value = 'dinner';
                  },
                  child: Text('DINNER'),
                  style: TextButton.styleFrom(
                    primary: (_category.value == 'dinner')
                        ? Colors.blue
                        : Colors.grey,
                  ),
                ),
              ],
            ),
            Expanded(
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, i) {
                        int status = _checkGridStatus();
                        if (i == status && !_isAllLoaded()) {
                          return Container(
                              height: 200,
                              width: 200,
                              child:
                                  Center(child: CircularProgressIndicator()));
                        } else if (i == status && _isAllLoaded()) {
                          return Container(
                            height: 200,
                            width: 200,
                            child: Center(
                              child: Text(
                                'Nothing to load.',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        } else {
                          if (_category.value == '') {
                            return Container(
                              height: 200,
                              width: 200,
                              child: Center(
                                  child: Text(
                                      _mealProvider.mealList[i].toString())),
                            );
                          }
                          if (_category.value == 'breakfast') {
                            return Container(
                              height: 200,
                              width: 200,
                              child:
                                  Text(_mealProvider.breakfast[i].toString()),
                            );
                          }
                          if (_category.value == 'lunch') {
                            return Container(
                              height: 200,
                              width: 200,
                              child: Text(_mealProvider.lunch[i].toString()),
                            );
                          }
                          if (_category.value == 'dinner') {
                            return Container(
                              height: 200,
                              width: 200,
                              child: Text(_mealProvider.dinner[i].toString()),
                            );
                          }

                          return Container(
                            height: 200,
                            width: 200,
                            child: Text(_mealProvider.search[i].toString()),
                          );
                        }
                      },
                      childCount: (_category.value == '')
                          ? _mealProvider.mealList.length + 1
                          : (_category.value == 'breakfast')
                              ? _mealProvider.breakfast.length
                              : (_category.value == 'lunch')
                                  ? _mealProvider.lunch.length
                                  : (_category.value == 'dinner')
                                      ? _mealProvider.dinner.length
                                      : _mealProvider.search.length,
                    ),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200.0,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        childAspectRatio: 1.5),
                  ),
                ],
              ),
              // child: GridView.builder(
              //   controller: _scrollController,
              //   padding: const EdgeInsets.all(10.0),
              //   itemCount: (_category.value == '')
              //       ? _mealProvider.mealList.length
              //       : (_category.value == 'breakfast')
              //           ? _mealProvider.breakfast.length
              //           : (_category.value == 'lunch')
              //               ? _mealProvider.lunch.length
              //               : (_category.value == 'dinner')
              //                   ? _mealProvider.dinner.length
              //                   : _mealProvider.search.length,
              //   itemBuilder: (ctx, i) {
              //     int status = _checkGridStatus();
              //     if (i == status) {
              //       return Center(child: CircularProgressIndicator());
              //     } else if (i == status && _isAllLoaded()) {
              //       return Center(
              //         child: Text(
              //           'Nothing to load.',
              //           style: TextStyle(color: Colors.white),
              //         ),
              //       );
              //     } else {
              //       if (_category.value == '') {
              //         return Container(

              //           child: Center(child: Text(_mealProvider.mealList[i].toString())),
              //         );
              //       }
              //       if (_category.value == 'breakfast') {
              //         return Container(
              //           child: Text(_mealProvider.breakfast[i].toString()),
              //         );
              //       }
              //       if (_category.value == 'lunch') {
              //         return Container(
              //           child: Text(_mealProvider.lunch[i].toString()),
              //         );
              //       }
              //       if (_category.value == 'dinner') {
              //         return Container(
              //           child: Text(_mealProvider.dinner[i].toString()),
              //         );
              //       }

              //       return Container(
              //         child: Text(_mealProvider.search[i].toString()),
              //       );
              //     }
              //   },
              //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: 4,
              //     childAspectRatio: 3 / 2,
              //     crossAxisSpacing: 10,
              //     mainAxisSpacing: 10,
              //   ),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}

enum MealTypes {
  all,
  breakfast,
}
