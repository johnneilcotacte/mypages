import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  //final String text;
  //final ValueChanged<String> onChanged;
  final String hintText;

  const SearchWidget({
    Key? key,
    //required this.text,
    //required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: Colors.black26),
      ),
      child: TextField(
        //controller: controller,
        decoration: InputDecoration(
          icon: Icon(Icons.search),
        ),
      ),
    );
  }
}
