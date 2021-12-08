import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_miniproject/config/route.dart';
import 'package:flutter_miniproject/module/screens/homes_screen.dart';
import 'package:flutter_miniproject/module/screens/authentication_screen.dart';
import 'package:flutter_miniproject/module/upload_file/upload_file.dart';

import 'package:flutter_miniproject/provider/const_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('${snapshot.error.toString()}'),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return ProviderScope(child: App());
        }
        return Center(
          child: CircularProgressIndicator(
            color: Colors.red,
          ),
        );
      },
    );
  }
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      //home: HomePage(),
      home: BonusPage(),
      debugShowCheckedModeBanner: false,
      //  initialRoute: RouteGenerator.loginRoute,
      //  onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
