import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iosstyleswitch/IosSwitch.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/themeprovider.dart';
import '../utils/colors.dart';

class ChangeThemeButton extends StatefulWidget {
  const ChangeThemeButton({Key? key}) : super(key: key);

  @override
  State<ChangeThemeButton> createState() => _ChangeThemeButtonState();
}

class _ChangeThemeButtonState extends State<ChangeThemeButton> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Switch.adaptive(
      value: themeProvider.isDarkMode,
      activeColor: Color.fromARGB(255, 4, 4, 4),
      activeTrackColor: Color.fromARGB(255, 91, 91, 91),
      inactiveThumbColor: AppColors.maincolor,
      inactiveTrackColor: Color.fromARGB(255, 198, 198, 193),
      materialTapTargetSize: MaterialTapTargetSize.padded,
      onChanged: (value) {
        final provider = Provider.of<ThemeProvider>(context, listen: false);
        provider.toggleTheme(value);
      },
    );
    // return IosSwitch(
    //   isActive: themeProvider.isDarkMode,
    //   size: 30,
    //   dotActiveColor: Color.fromARGB(255, 7, 227, 95),
    //   mainBorderRadiusValue: 3,
    //   activeBackgroundColor: Color.fromARGB(255, 91, 91, 91),
    //   disableBackgroundColor: Color.fromARGB(255, 91, 91, 91),
    //   onChanged: (value) {
    //     final provider = Provider.of<ThemeProvider>(context, listen: false);
    //     provider.toggleTheme(value);
    //   },
    // );
  }
}
