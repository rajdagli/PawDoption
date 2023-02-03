import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buttonWidget(Icons.map_rounded, Colors.black),
          buttonWidget(Icons.star_rounded, Colors.black),
          buttonWidget(Icons.home_rounded, Colors.black),
          buttonWidget(Icons.chat_rounded, Colors.black),
          buttonWidget(Icons.favorite_rounded, Colors.black)
        ],
      ),);
  }
}

Widget buttonWidget(IconData icon, Color color){
  return Container(
    height: 60,
    width: 60 ,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white,
      // border: Border.all(color: color )
    ),
    child: Icon(icon,
      color: color,
      size: 45,),
  );
}