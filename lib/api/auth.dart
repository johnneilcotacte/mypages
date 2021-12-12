import 'package:http/http.dart' as http;
import 'package:http/http.dart';

//https://firebase.flutter.dev/docs/storage/usage/
class AuthAPI {
  String _loginuri = 'https://wca-meal-planner.herokuapp.com/';

  Future<Response?> logInUser(
      {required String email, required String password}) async {
    print(password);
    try {
      var url = Uri.parse(_loginuri + 'auth');
      var response = await http.post(
        url,
        body: {
          "identifier": email,
          "password": password,
        },
      );

      // if (response.statusCode == 200) {
      //   // print(response.body);
      //   return true;
      // } else {
      //   // print('invalid');
      //   return false;
      // }
      return response;
    } catch (er) {
      return null;
      //throw Exception(er);
    }
  }

  Future<Response?> createUser(
      {
      // required String username,
      // required String password,
      // required String firstname,
      // required String lastname,
      // required String email,
      required Map<String, dynamic> signup}) async {
    try {
      var url = Uri.parse(_loginuri + 'users');
      var response = await http.post(url,
          // body: {
          //   "username": "$username",
          //   "password": "$password",
          //   "first_name": "$firstname",
          //   "last_name": "$lastname",
          //   "email": "$email",
          // },
          body: signup);

      // if (response.statusCode == 201) {
      //   print(response.body);
      //   return response.body;
      // } else {
      //   print('invalid');
      //   return response.body;
      // }
      return response;
    } catch (er) {
      //return er.toString();
      return null;
    }
  }
}

// class InitialDummyMeals {
//   Future<List<Meal>> initializeListBlog() async {
//     Uint8List? _image0 = (await rootBundle.load('assets/images/hotdog.png'))
//         .buffer
//         .asUint8List();
//     Uint8List? _image1 = (await rootBundle.load('assets/images/lechon.jpg'))
//         .buffer
//         .asUint8List();
//     Uint8List? _image2 = (await rootBundle.load('assets/images/paksiw.jpg'))
//         .buffer
//         .asUint8List();

//     return [
//       Meal(
//           id: '1',
//           name: 'hotdog',
//           image: 'https://picsum.photos/250?image=9',
//           ingredients: [
//             'hotdog',
//           ]),
//       Meal(
//           id: '2',
//           name: 'Lechon',
//           image:
//               'https://firebasestorage.googleapis.com/v0/b/flutter-additionals.appspot.com/o/files%2FCornSiLog%20(%20Corned%20Beef%2C%20Sinangag%2C%20Itlog)%20with%20Highlands%20Gold%20Corned%20Beef%20-%20The%20Peach%20Kitchen.png?alt=media&token=20db0da1-6851-49e0-b10c-61192a109f59',
//           ingredients: ['pig', 'bawang', 'msg']),
//       Meal(
//           id: '3',
//           name: 'Lechon Paksiw',
//           image:
//               'https://firebasestorage.googleapis.com/v0/b/flutter-additionals.appspot.com/o/files%2FCornSiLog%20(%20Corned%20Beef%2C%20Sinangag%2C%20Itlog)%20with%20Highlands%20Gold%20Corned%20Beef%20-%20The%20Peach%20Kitchen.png?alt=media&token=20db0da1-6851-49e0-b10c-61192a109f59',
//           ingredients: ['lechon', 'tuyo']),
//     ];
//   }
// }
