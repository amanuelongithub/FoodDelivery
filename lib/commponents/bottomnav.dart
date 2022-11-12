import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fooddelivery/screen/authentication.dart';
import 'package:fooddelivery/screen/cart_screen.dart';
import 'package:fooddelivery/screen/feed_screen.dart';
import 'package:fooddelivery/screen/order_screen.dart';
import 'package:fooddelivery/screen/setting_screen.dart';
import 'package:fooddelivery/utils/colors.dart';

import 'default_button.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // addData();
  }

  // addData() async {
  //   UserProvider _userProvider = Provider.of(context, listen: false);
  //   await _userProvider.refreshUser();
  // }

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List selected = [
    const FeedScreen(),
    OrderScreen(),
    Container(),
    const SettingScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: selected[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: _navigateBottomBar,
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.maincolor,
        unselectedItemColor: AppColors.seccolor,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/img/home.svg",
                // height: 26,
                color: _selectedIndex == 0
                    ? Color.fromARGB(255, 215, 162, 4)
                    : Colors.grey,
                semanticsLabel: 'A red up arrow'),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/img/order.svg",
                height: 26,
                color: _selectedIndex == 1
                    ? Color.fromARGB(255, 215, 162, 4)
                    : Colors.grey,
                semanticsLabel: 'A red up arrow'),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.star,
              color: _selectedIndex == 2
                  ? Color.fromARGB(255, 215, 162, 4)
                  : Colors.grey,
              size: 20,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/img/settings-outline.svg",
                  height: 26,
                  color: _selectedIndex == 3
                      ? Color.fromARGB(255, 215, 162, 4)
                      : Colors.grey,
                  semanticsLabel: 'A red up arrow'),
              label: "")
        ],
      ),
    );
  }
}
