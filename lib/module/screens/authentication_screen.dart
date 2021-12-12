import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_miniproject/config/route.dart';
import 'package:flutter_miniproject/logic/usercredential_checker.dart';
import 'package:flutter_miniproject/module/authentication_screen_components/filipino_recipe.dart';
import 'package:flutter_miniproject/module/authentication_screen_components/login_form.dart';
import 'package:flutter_miniproject/module/authentication_screen_components/subtitle_card.dart';
import 'package:flutter_miniproject/provider/userauth_api_provider.dart';
import 'package:flutter_miniproject/responsive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    Timer _everysecond;
    List<String> _backgroundasset = [
      'assets/images/login_header.jpg',
      'assets/images/login_header2.jpg',
      'assets/images/login_header3.jpg'
    ];
    // List<BoxDecoration> _backgroundasset = [
    //   BoxDecoration(
    //     image: DecorationImage(
    //       image: AssetImage('assets/images/login_header.jpg'),
    //       fit: BoxFit.fill,
    //     ),
    //   ),
    //   BoxDecoration(
    //     image: DecorationImage(
    //       image: AssetImage('assets/images/lechon.jpg'),
    //       fit: BoxFit.fill,
    //     ),
    //   ),
    //   BoxDecoration(
    //     image: DecorationImage(
    //       image: AssetImage('assets/images/hotdog.png'),
    //       fit: BoxFit.fill,
    //     ),
    //   ),
    // ];
    final _background = useState(0);

    useEffect(
      () {
        _everysecond = Timer.periodic(Duration(seconds: 7), (Timer t) {
          if (_background.value == 2) {
            _background.value = 0;
          } else {
            _background.value++;
          }
        });
        return _everysecond.cancel;
      },
      [],
    );
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 801,
              child: Stack(
                alignment: AlignmentDirectional.center,
                clipBehavior: Clip.none,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      //decoration: _backgroundasset[_background.value],
                      width: _width,
                      height: 600,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image.asset('assets/images/login_header.jpg'),
                        // child: Image.asset(_backgroundasset[_background.value]),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 600.01,
                    //top: 0,
                    child: Container(
                      height: 200,
                      width: _width,
                      color: Colors.transparent,
                    ),
                  ),
                  Positioned(
                    top: 300,
                    //top: 0,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (Responsive.isDesktop(context))
                            Container(
                              child: SubtitleCard(),
                            ),
                          SizedBox(
                            width: 20,
                          ),
                          LoginForm(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              //height: 220,
              height: 20,
            ),
            if (!Responsive.isDesktop(context))
              Container(
                padding: EdgeInsets.only(top: 30, bottom: 30),
                width: double.infinity,
                color: Colors.white,
                child: Center(
                  child: SubtitleCard(),
                ),
              ),
            SizedBox(
              height: 20,
            ),
            FilipinoRecipe(),
            SizedBox(
              height: 500,
            ),
            Container(
              height: 100,
              width: double.infinity,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
