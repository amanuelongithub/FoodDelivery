import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fooddelivery/utils/colors.dart';
import 'package:fooddelivery/utils/dimension.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import '../components/profile_card.dart';
import '../provider/themeprovider.dart';
import 'authentication.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String email = "";
  @override
  void initState() {
    super.initState();
    getEmail();
  }

  void getEmail() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      email = (snap.data() as Map<String, dynamic>)['email'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark =
        Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
            ? "dark"
            : "light";
    return Scaffold(
      backgroundColor:
          isDark == "dark" ? null : Color.fromARGB(255, 231, 231, 231),
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor:
            isDark == "dark" ? null : Color.fromARGB(255, 231, 231, 231),
        title: Text("  Settings",
            style: TextStyle(
              fontSize: 18,
              color: isDark == "dark"
                  ? Color.fromARGB(255, 231, 231, 231)
                  : Color.fromARGB(255, 38, 38, 38),
              fontWeight: FontWeight.bold,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: Text("General",
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.maincolor,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            const SizedBox(
              height: 15,
            ),
            Material(
                borderRadius: BorderRadius.circular(15), child: ProfileCard()),
            // InkWell(
            //   onTap: () {},
            //   borderRadius: BorderRadius.circular(20),
            //   splashColor: Colors.transparent,
            //   child: ListTile(
            //     leading: SvgPicture.asset("assets/img/user-regular.svg",
            //         width: 25,
            //         height: 25,
            //         color: Colors.grey,
            //         // color: isDark == "dark" ? Colors.white : Colors.black54,
            //         semanticsLabel: ''),
            //     title: const Text('Edit account'),
            //     subtitle: Text("${email}"),
            //     trailing: const Icon(
            //       FontAwesomeIcons.chevronRight,
            //       color: Colors.grey,
            //       size: 20,
            //     ),
            //   ),
            // ),
            const Divider(
              color: Color.fromARGB(255, 159, 159, 159),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {},
                    splashColor: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    child: ListTile(
                      leading: Icon(
                        Icons.location_on_outlined,
                        color: Colors.grey,
                      ),
                      title: Text(
                        'Address',
                        style: TextStyle(
                          fontSize: Dimensions.font16,
                        ),
                      ),
                      trailing: Icon(
                        FontAwesomeIcons.chevronRight,
                        color: Colors.grey,
                        size: Dimensions.height20,
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () {},
                    splashColor: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    child: ListTile(
                      leading: Icon(
                        Icons.bookmark_border_outlined,
                        color: Colors.grey,
                      ),
                      title: Text(
                        'Bookmark',
                        style: TextStyle(
                          fontSize: Dimensions.font16,
                        ),
                      ),
                      trailing: Icon(
                        FontAwesomeIcons.chevronRight,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      // Get.off(() => const AuthPage());
                      Get.offAllNamed('/Auth');
                    },
                    splashColor: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    child: ListTile(
                      leading: Icon(
                        FontAwesomeIcons.rightFromBracket,
                        color: Colors.grey,
                      ),
                      title: Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: Dimensions.font16,
                        ),
                      ),
                      trailing: Icon(
                        FontAwesomeIcons.chevronRight,
                        color: Colors.grey,
                        size: Dimensions.font20,
                      ),
                    ),
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 159, 159, 159),
                  ),
                  SizedBox(
                    height: Dimensions.height25,
                  ),

                  Text("About",
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.maincolor,
                        fontWeight: FontWeight.bold,
                      )),
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(20),
                    splashColor: Colors.transparent,
                    child: ListTile(
                      leading: Icon(
                        FontAwesomeIcons.question,
                        color: Colors.grey,
                        size: Dimensions.iconSize20,
                      ),
                      title: Text('About'),
                      trailing: Icon(
                        FontAwesomeIcons.chevronRight,
                        color: Colors.grey,
                        size: Dimensions.iconSize18,
                      ),
                    ),
                  ),
                  // check for update
                  InkWell(
                    onTap: () {},
                    splashColor: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    child: ListTile(
                      leading: Icon(
                        FontAwesomeIcons.arrowsRotate,
                        color: Colors.grey,
                      ),
                      title: Text(
                        'Check for update',
                        style: TextStyle(
                          fontSize: Dimensions.font16,
                        ),
                      ),
                      trailing: Icon(
                        FontAwesomeIcons.chevronRight,
                        color: Colors.grey,
                        size: Dimensions.iconSize18,
                      ),
                    ),
                  ),

                  const Divider(
                    color: Color.fromARGB(255, 159, 159, 159),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  Text("Feedback",
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.maincolor,
                        fontWeight: FontWeight.bold,
                      )),

                  InkWell(
                    onTap: () {},
                    splashColor: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    child: ListTile(
                      leading: Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.grey,
                      ),
                      title: Text(
                        'Report bug',
                        style: TextStyle(
                          fontSize: Dimensions.font16,
                        ),
                      ),
                      trailing: Icon(
                        FontAwesomeIcons.chevronRight,
                        color: Colors.grey,
                        size: Dimensions.iconSize18,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {},
                    splashColor: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    child: ListTile(
                      leading: Icon(
                        Icons.send_outlined,
                        color: Colors.grey,
                      ),
                      title: Text(
                        'Send feedback',
                        style: TextStyle(
                          fontSize: Dimensions.font16,
                        ),
                      ),
                      trailing: Icon(
                        FontAwesomeIcons.chevronRight,
                        color: Colors.grey,
                        size: Dimensions.iconSize18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
