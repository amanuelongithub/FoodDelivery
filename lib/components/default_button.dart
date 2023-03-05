import 'package:flutter/material.dart';

import '../utils/colors.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    this.primcolor = AppColors.maincolor,
    required this.text,
    required this.press,
    this.width = 200.00,
    this.hight = 50.00,
  }) : super(key: key);
  final String? text;
  final double width;
  final double hight;
  final Color primcolor;
  final Function() press;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9), // <-- Radius
        ),
        foregroundColor: Colors.black38,
        backgroundColor: primcolor,
        shadowColor: Colors.transparent,
        minimumSize: Size(width, hight),
      ),
      onPressed: press,
      child: Text(
        text!,
        style: TextStyle(
            fontFamily: 'HandoSoft',
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w800),
      ),
    );
  }
}
