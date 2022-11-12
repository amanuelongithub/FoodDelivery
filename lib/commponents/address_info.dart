import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fooddelivery/utils/utilil.dart';
import '../provider/themeprovider.dart';
import 'package:provider/provider.dart';
import '../utils/colors.dart';
import 'package:marquee/marquee.dart';

class AddressInfoCard extends StatelessWidget {
  final snap;
  const AddressInfoCard({Key? key, this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark =
        Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
            ? "dark"
            : "light";
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            //  Delivery assress
            Text(
              "Delivery address",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: isDark == "dark"
                    ? Color.fromARGB(221, 49, 49, 49)
                    : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: isDark == "dark"
                        ? Color.fromARGB(137, 89, 89, 89)
                        : Colors.grey.withOpacity(0.4),
                    offset: const Offset(5, 5),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.map,
                      color: AppColors.maincolor,
                    ),
                    Container(
                      width: 250,
                      height: 50,
                      padding: const EdgeInsets.all(12),
                      child: Marquee(
                        text: userLocation != null
                            ? userLocation.toString()
                            : '...',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                        blankSpace: 80,
                        velocity: 80,
                        scrollAxis: Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 15,
            ),
            Text(
              "Contact person name",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: isDark == "dark"
                    ? Color.fromARGB(221, 49, 49, 49)
                    : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: isDark == "dark"
                        ? Color.fromARGB(137, 89, 89, 89)
                        : Colors.grey.withOpacity(0.4),
                    offset: const Offset(5, 5),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      FontAwesomeIcons.user,
                      size: 20,
                      color: AppColors.maincolor,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      snap['username'],
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            )

            //  Contact Person phone

            ,
            SizedBox(
              height: 15,
            ),
            Text(
              "Contact person number",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: isDark == "dark"
                    ? Color.fromARGB(221, 49, 49, 49)
                    : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: isDark == "dark"
                        ? Color.fromARGB(137, 89, 89, 89)
                        : Colors.grey.withOpacity(0.4),
                    offset: const Offset(5, 5),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.phone_outlined,
                      color: AppColors.maincolor,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      snap['phoneNum'],
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
