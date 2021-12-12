import 'package:flutter/material.dart';
import 'package:flutter_miniproject/model/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final currentUserProvider = ChangeNotifierProvider<ShowUserData>((ref) {
  return ShowUserData();
});

class ShowUserData extends ChangeNotifier {
  // String _username = '';
  // String _avatarUrl = '';
  // String _token = '';
  // String _id = '';

  // String? get id => _id;
  // String? get token => _token;
  // String? get username => _username;
  // String? get avatarUrl => _avatarUrl;

  User? _user = User();

  void createInstance(User? newUser) {
    _user = newUser;
    notifyListeners();
  }

  User? get user => _user;
}



//  final currentUserPrivateDataProvider = Provider<ShowUserData>((ref) {
//   return ShowUserData();
// });

// class ShowUserData {

//   String _token = '';
//   String _id = '';

//    String? get id => _id;
//   String? get name => _token;


// }
