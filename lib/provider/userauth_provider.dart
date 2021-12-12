import 'package:flutter/cupertino.dart';
import 'package:flutter_miniproject/api/auth.dart';

import 'package:flutter_miniproject/provider/userauth_api_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authProvider = ChangeNotifierProvider<UserAuth>((ref) {
  final initialauth = ref.watch(authAPIProvider).auth;
  return UserAuth(api: initialauth);
});

class UserAuth extends ChangeNotifier {
  AuthAPI api;
  UserAuth({required this.api});

  //Future<String?>
}
