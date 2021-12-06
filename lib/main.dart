import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_miniproject/config/route.dart';
import 'package:flutter_miniproject/module/screens/homes_screen.dart';
import 'package:flutter_miniproject/module/screens/authentication_screen.dart';

import 'package:flutter_miniproject/provider/const_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
      //home: LoginPage(),
      debugShowCheckedModeBanner: false,
      // initialRoute: RouteGenerator.loginRoute,
      // onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
