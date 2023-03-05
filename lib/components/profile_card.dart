import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/utils/dimenstions.dart';
import 'package:provider/provider.dart';
import '../provider/themeprovider.dart';
import 'package:get/get.dart';
import 'package:pixel_perfect/pixel_perfect.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => ProfileCardState();
}

class ProfileCardState extends State<ProfileCard> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final scale = Dimensions.mockupWidth / width;
    final textScaleFactor = width / Dimensions.mockupWidth;

    final isDark =
        Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
            ? "dark"
            : "light";

    return InkWell(
      onTap: () {
        Get.toNamed('/editaccount');
      },
      child: Container(
        margin: const EdgeInsets.all(5),
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

          // gradient: LinearGradient(
          //     begin: Alignment.centerLeft,
          //     end: Alignment.centerRight,
          //     colors: [
          //       Color.fromARGB(255, 16, 16, 16),
          //       Color.fromARGB(255, 177, 177, 177),
          //       Color.fromARGB(255, 16, 16, 16),
          //       Color.fromARGB(255, 16, 16, 16),
          //       Color.fromARGB(255, 255, 174, 0),
          //     ]),
        ),
        padding: EdgeInsets.all(2),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.height15),
            color: isDark == "dark"
                ? Color.fromARGB(255, 61, 57, 57)
                : Color.fromARGB(255, 212, 212, 212),
          ),
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('user')
                      .doc(_auth.currentUser!.uid)
                      .snapshots()
                      .first,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      {
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColors.maincolor,
                          ),
                        );
                      }
                    }
                    if (!snapshot.hasData) {
                      return const Center(
                          child: Text(
                        "user not found",
                        style: TextStyle(
                            color: Color.fromARGB(184, 138, 138, 138)),
                      ));
                    }
                    if (snapshot.hasError) {
                      return Center(
                          child: Text(
                        "Unabel to get user data",
                        style: TextStyle(
                            color: Color.fromARGB(184, 138, 138, 138)),
                      ));
                    } else if (snapshot.hasData) {
                      return buildUserProfile(isDark, snapshot.data);
                    } else {
                      return Container();
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUserProfile(String isDark, final snapshot) {
    final width = MediaQuery.of(context).size.width;
    final scale = Dimensions.mockupWidth / width;
    final textScaleFactor = width / Dimensions.mockupWidth;

    return Expanded(
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CircleAvatar(
              radius: Dimensions.height40,
              backgroundColor: isDark == "dark"
                  ? Color.fromARGB(247, 250, 250, 250)
                  : Color.fromARGB(209, 38, 38, 38),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: CachedNetworkImage(
                  imageUrl: snapshot['userProfile'],
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => SizedBox(
                    height: double.infinity,
                    child: Center(
                        child: Text(
                      "!",
                      textScaleFactor: textScaleFactor,
                    )),
                  ),
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                snapshot['fullName'],
                style: TextStyle(
                    color: isDark == "dark"
                        ? Color.fromARGB(255, 231, 231, 231)
                        : Color.fromARGB(255, 38, 38, 38),
                    fontSize: Dimensions.font20,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                snapshot['phoneNum'],
                style: TextStyle(
                    color: isDark == "dark"
                        ? Color.fromARGB(255, 231, 231, 231)
                        : Color.fromARGB(255, 38, 38, 38),
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
              ),
              Text(
                snapshot['email'],
                style: TextStyle(
                    color: isDark == "dark"
                        ? Color.fromARGB(255, 231, 231, 231)
                        : Color.fromARGB(255, 38, 38, 38),
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
