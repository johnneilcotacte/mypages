import 'package:flutter_miniproject/api/auth.dart';
import 'package:flutter_miniproject/api/home_screen_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final initialhomescreenProvider = Provider<HomeScreenAPIconnection>((ref) {
  return HomeScreenAPIconnection();
});

class HomeScreenAPIconnection {
  final homescreen = HomeScreenAPI();
}
