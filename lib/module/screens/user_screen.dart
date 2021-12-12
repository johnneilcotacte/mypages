import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_miniproject/model/screen_argument.dart';
import 'package:flutter_miniproject/model/user.dart';
import 'package:flutter_miniproject/module/user_screen_components/profile_pic_widget.dart';

class UserPage extends HookWidget {
  const UserPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as UserScreenArguments;
    return Scaffold(
      body: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(),
          body: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              ProfilePicWidget(
                imagePath:
                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                onClicked: () {
                  //TODO: Add EditUserScreen file
                  /*
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => EditUserScreen()),
                  );*/
                },
              ),
              const SizedBox(height: 30),
              Column(
                children: [
                  Text(
                    '${args.user!.firstName!} ${args.user!.lastName!}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    args.user!.email!,
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
