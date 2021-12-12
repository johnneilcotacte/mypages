import 'package:flutter/material.dart';
import 'package:flutter_miniproject/responsive.dart';

class MealsPerDay extends StatelessWidget {
  const MealsPerDay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: GridView.count(
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: (Responsive.isDesktop(context)) ? 3 : 1,
        children: [
          InkWell(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/images/hotdog.png',
                    ),
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.9), BlendMode.dstATop),
                    fit: BoxFit.cover),
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Breakfast',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontStyle: FontStyle.italic),
                    ),
                    Text(
                      'Hotdog',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontStyle: FontStyle.italic),
                    ),
                    // ElevatedButton(
                    //   style: ElevatedButton.styleFrom(
                    //     primary: Colors.white, // background
                    //     //onPrimary: Colors.white, // foreground
                    //   ),
                    //   onPressed: () {},
                    //   child: Text(
                    //     'Eat Out',
                    //     style: TextStyle(color: Colors.black),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/images/lechon.jpg',
                    ),
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.9), BlendMode.dstATop),
                    fit: BoxFit.cover),
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Lunch',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontStyle: FontStyle.italic),
                    ),
                    Text(
                      'Crispy Lechon',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontStyle: FontStyle.italic),
                    ),
                    // ElevatedButton(
                    //   style: ElevatedButton.styleFrom(
                    //     primary: Colors.white, // background
                    //     //onPrimary: Colors.white, // foreground
                    //   ),
                    //   onPressed: () {},
                    //   child: Text(
                    //     'Eat Out',
                    //     style: TextStyle(color: Colors.black),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/images/paksiw.jpg',
                    ),
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.9), BlendMode.dstATop),
                    fit: BoxFit.cover),
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Dinner',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontStyle: FontStyle.italic),
                    ),
                    Text(
                      'Spicy Lechon Paksiw',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontStyle: FontStyle.italic),
                    ),
                    // ElevatedButton(
                    //   style: ElevatedButton.styleFrom(
                    //     primary: Colors.white, // background
                    //     //onPrimary: Colors.white, // foreground
                    //   ),
                    //   onPressed: () {},
                    //   child: Text(
                    //     'Eat Out',
                    //     style: TextStyle(color: Colors.black),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
