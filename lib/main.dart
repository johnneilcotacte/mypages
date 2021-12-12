import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_miniproject/config/route.dart';
import 'package:flutter_miniproject/module/screens/homes_screen.dart';
import 'package:flutter_miniproject/module/screens/authentication_screen.dart';
import 'dart:async';
import 'package:flutter_miniproject/provider/const_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//flutter run -d chrome --web-port 5000
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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

      debugShowCheckedModeBanner: false,
      initialRoute: RouteGenerator.loginRoute,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   late StreamSubscription<User?> _sub;
//   final _navigatorKey = new GlobalKey<NavigatorState>();

//   checkAuthentification() async {
//     FirebaseAuth.instance.userChanges().listen((event) {
//       _navigatorKey.currentState!.pushReplacementNamed(
//         event != null ? RouteGenerator.homeRoute : RouteGenerator.loginRoute,
//       );
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _sub = FirebaseAuth.instance.userChanges().listen((event) {
//       print('event');
//       _navigatorKey.currentState!.pushReplacementNamed(
//         event != null ? RouteGenerator.homeRoute : RouteGenerator.loginRoute,
//       );
//     });
//     // await checkAuthentification();
//   }

//   @override
//   void dispose() {
//     _sub.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       key: _navigatorKey,
//       title: 'Flutter Demo',
//       //home: HomePage(),
//       //home: LoginPage(),
//       // home: AllMealsPage(),
//       debugShowCheckedModeBanner: false,
//       initialRoute: RouteGenerator.loginRoute,
//       onGenerateRoute: RouteGenerator.generateRoute,
//     );
//   }
// }
