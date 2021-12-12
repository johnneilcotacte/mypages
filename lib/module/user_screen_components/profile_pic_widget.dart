import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ProfilePicWidget extends HookWidget {
  final String imagePath;
  final bool isEdit;
  final VoidCallback onClicked;

  const ProfilePicWidget({
    Key? key,
    required this.imagePath,
    this.isEdit = false,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          ClipOval(
            child: Material(
              color: Colors.transparent,
              child: Ink.image(
                image: NetworkImage(imagePath),
                fit: BoxFit.cover,
                width: 128,
                height: 128,
                child: InkWell(onTap: onClicked),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildCircle(
              color: Colors.white,
              all: 3,
              child: buildCircle(
                color: color,
                all: 8,
                child: Icon(
                  isEdit ? Icons.add_a_photo : Icons.edit,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
