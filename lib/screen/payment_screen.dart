import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../provider/themeprovider.dart';
import '../utils/colors.dart';

class PaymentScreen extends StatefulWidget {
  // String file;
  // String name;
  PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark =
        Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
            ? "dark"
            : "light";
    return Scaffold(
        body: Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: Column(children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.ar,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: IconButton(
                color: isDark == "dark" ? Colors.white : Colors.black54,
                icon: Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            Text("Payment Methods",
                style: TextStyle(
                  fontSize: 20,
                  // fontWeight: FontWeight.bold,
                )),

            // Container()
          ],
        ),
        Divider(
          color: Colors.grey,
        ),
        SizedBox(height: 30),
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/img/paypal.png'),
            // scale: 3.0,
            fit: BoxFit.cover,
            alignment: Alignment.center,
          )),
          child: Container(
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 29, 119, 154).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      width: 2,
                      color: Colors.white30,
                    ),
                  ),
                  // child: Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     // Padding(
                  //     //   padding: const EdgeInsets.only(top: 20, left: 30),
                  //     //   child: Text(
                  //     //     "PayPal",
                  //     //     style: TextStyle(
                  //     //         color: AppColors.seccolor,
                  //     //         fontSize: 30,
                  //     //         fontWeight: FontWeight.bold,
                  //     //         fontStyle: FontStyle.italic),
                  //     //   ),
                  //     // ),
                  //     // Padding(
                  //     //   padding: const EdgeInsets.only(top: 40, left: 30),
                  //     //   child: Text(
                  //     //     "####  ####  #### ####",
                  //     //     style: TextStyle(
                  //     //       color: AppColors.seccolor,
                  //     //       fontSize: 30,
                  //     //       fontFamily: '',
                  //     //       // fontWeight: FontWeight.bolnd,
                  //     //       // fontStyle: FontStyle.italic
                  //     //     ),
                  //     //   ),
                  //     // ),
                  //   ],
                  // ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 30),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26),
              image: DecorationImage(
                image: AssetImage(
                  'assets/img/telebir.png',
                ),
                fit: BoxFit.fill,
                // scale: 1.0,
                alignment: Alignment.center,
              )),
          child: Container(
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 29, 119, 154).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      width: 2,
                      color: Colors.white30,
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ]),
    ));
  }
}
