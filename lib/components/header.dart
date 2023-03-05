import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fooddelivery/utils/dimenstions.dart';
import 'package:provider/provider.dart';

import '../provider/themeprovider.dart';
import '../utils/colors.dart';

class Header extends StatefulWidget {
  final snap;
  const Header({Key? key, this.snap}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    final isDark =
        Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
            ? "dark"
            : "light";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(children: [
            TextSpan(
                text: "👋Hello:",
                style: TextStyle(
                    fontSize: Dimensions.font30,
                    color: isDark == "dark" ? Colors.white : Colors.black,
                    fontFamily: "HandoSoft",
                    fontWeight: FontWeight.bold)),
            TextSpan(
                text: ' ${widget.snap['username']}',
                style: TextStyle(
                    fontSize: Dimensions.font25,
                    color: AppColors.maincolor,
                    fontFamily: "HandoSoft",
                    fontWeight: FontWeight.bold)),
          ]),
        ),
        SizedBox(
          height: 10,
        ),
         Text(
          "Select your meal for the day.",
          style: TextStyle(
              fontSize: Dimensions.font20,
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
