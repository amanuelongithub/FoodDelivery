import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

    // return ThemeModeSelector(
    //   height: 29,
    //   onChanged: (value) {
    //     final provider = Provider.of<ThemeProvider>(context, listen: false);
    //     value == ThemeMode.dark
    //         ? provider.toggleTheme(true, context)
    //         : provider.toggleTheme(false, context);
    //   },
    // );

    //     LiteRollingSwitch(
    //   value: themeProvider.isDarkMode,
    //   textOn: "dark",
    //   textOff: "light",
    //   colorOn: Colors.grey,
    //   colorOff: Colors.black,
    //   onChanged: (bool value) {
    //     final provider = Provider.of<ThemeProvider>(context, listen: false);
    //     provider.toggleTheme(value);
    //   },
    //   iconOn: Icons.wb_sunny,
    //   iconOff: FontAwesomeIcons.moon,
    // );
  }
}
