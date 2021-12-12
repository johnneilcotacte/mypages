import 'package:flutter/material.dart';

class RecipeInput extends StatelessWidget {
  final TextEditingController textController;

  const RecipeInput({
    Key? key,
    required this.textController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        child: TextFormField(
          controller: textController,
          decoration: InputDecoration(hintText: 'Add an ingredient'),
        ),
      ),
    );
  }
}
