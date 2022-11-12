import 'package:flutter/material.dart';

import '../utils/colors.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    this.primcolor = Colors.white,
    required this.text,
    required this.press,
  }) : super(key: key);
  final String? text;
  final Color primcolor;
  final Function() press;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9), // <-- Radius
          ),
          onPrimary: Colors.black38,
          primary: AppColors.maincolor,
          shadowColor: Colors.transparent,
          minimumSize: Size(360, 50)),
      onPressed: press,
      child: Text(
        text!,
        style: TextStyle(
            fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}
