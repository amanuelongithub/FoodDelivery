import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fooddelivery/commponents/bottomnav.dart';
import 'package:fooddelivery/screen/cart_screen.dart';
import 'package:provider/provider.dart';
import '../provider/themeprovider.dart';
import 'package:get/get.dart';
import 'package:animations/animations.dart';

import '../utils/colors.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    final isDark =
        Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
            ? "dark"
            : "light";
    final FirebaseAuth _auth = FirebaseAuth.instance;

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('user')
            .doc(_auth.currentUser!.uid)
            .collection('cart')
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          // final hasdata = snapshot.data.docs.length.toString();
          return Badge(
            badgeContent: Text(
              snapshot.hasData ? snapshot.data!.docs.length.toString() : '0',
              style: TextStyle(color: Colors.black),
            ),
            badgeColor: AppColors.maincolor,
            child: InkResponse(
              radius: 28,
              splashColor: Color.fromARGB(221, 255, 193, 7),
              onTap: () => Get.to(() {
                return CartScreen();
              }),
              containedInkWell: false,
              child: SvgPicture.asset("assets/img/shopping-cart-outline.svg",
                  width: 30,
                  height: 30,
                  color: isDark == "dark" ? Colors.white : Colors.black54,
                  semanticsLabel: ''),
            ),
          );
        });
  }
}
/*
 OpenContainer(
              closedBuilder: (context, VoidCallback openContainer_) =>
                  BottomNavBar(),
              openBuilder: (context, _) => CartScreen());
*/
