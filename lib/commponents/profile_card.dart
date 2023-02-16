import 'package:flutter/material.dart';
import 'package:fooddelivery/utils/dimenstions.dart';
import 'package:provider/provider.dart';
import '../provider/themeprovider.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => ProfileCardState();
}

class ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    final isDark =
        Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
            ? "dark"
            : "light";
    return Container(
      margin: EdgeInsets.all(5),
      width: double.infinity,
      height: 120,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.height15),
          // boxShadow: [
          //   BoxShadow(
          //     color: isDark == "dark"
          //         ? Color.fromARGB(137, 89, 89, 89)
          //         : Colors.grey.withOpacity(0.4),
          //     offset: const Offset(10, 10),
          //     blurRadius: 20,
          //   ),
          // ],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromARGB(255, 16, 16, 16),
                Color.fromARGB(255, 177, 177, 177),
                Color.fromARGB(255, 16, 16, 16),
                Color.fromARGB(255, 16, 16, 16),
                Color.fromARGB(255, 255, 174, 0),
              ])),
      padding: EdgeInsets.all(2),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.height15),
          color: isDark == "dark"
              ? Color.fromARGB(209, 38, 38, 38)
              : Color.fromARGB(197, 212, 212, 212),
        ),
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: CircleAvatar(
                radius: Dimensions.height45,
                backgroundImage: AssetImage('assets/img/av.jpg'),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Johannes Milke",
                    style: TextStyle(
                        color: isDark == "dark"
                            ? Color.fromARGB(255, 231, 231, 231)
                            : Color.fromARGB(255, 38, 38, 38),
                        fontSize: Dimensions.font20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "09458757485",
                    style: TextStyle(
                        color: isDark == "dark"
                            ? Color.fromARGB(255, 231, 231, 231)
                            : Color.fromARGB(255, 38, 38, 38),
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                  Text(
                    "johannesmilke@gmial.com",
                    style: TextStyle(
                        color: isDark == "dark"
                            ? Color.fromARGB(255, 231, 231, 231)
                            : Color.fromARGB(255, 38, 38, 38),
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
