import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fooddelivery/commponents/changethemebutton.dart';
import 'package:fooddelivery/provider/themeprovider.dart';
import 'package:fooddelivery/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import '../commponents/cart_button.dart';
import '../commponents/header.dart';
import '../commponents/post_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark =
        Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
            ? "dark"
            : "light";
    return SafeArea(
      child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [ChangeThemeButton(), Cart()],
                ),
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('user')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .snapshots(), //get all data and streambuilder used as as real time
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: Text(
                            "...",
                            style: TextStyle(color: AppColors.maincolor),
                          ));
                        }
                        if (!snapshot.hasData) {
                          return const Center(
                              child: Text(
                            "...",
                            style: TextStyle(
                                color: Color.fromARGB(184, 138, 138, 138)),
                          ));
                        }
                        if (snapshot.hasError) {
                          return Center(
                              child: Text(
                            "...",
                            style: TextStyle(
                                color: Color.fromARGB(184, 138, 138, 138)),
                          ));
                        } else if (snapshot.hasData) {
                          return Header(
                            snap: snapshot.data,
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Expanded(
                        child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('posts')
                          .snapshots(), //get all data and streambuilder used as as real time
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          {
                            return Center(
                              child: CircularProgressIndicator(
                                color: AppColors.maincolor,
                              ),
                            );
                          }
                        }
                        if (snapshot.data!.docs.isEmpty) {
                          return const Center(
                              child: Text(
                            "No Content, Come back later. Thankyou",
                            style: TextStyle(
                                color: Color.fromARGB(184, 138, 138, 138)),
                          ));
                        }
                        if (snapshot.hasError) {
                          return Center(
                              child: Text(
                            "Unabel to get the data",
                            style: TextStyle(
                                color: Color.fromARGB(184, 138, 138, 138)),
                          ));
                        }

                        return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              if (snapshot.hasData) {
                                return PostCard(
                                  snap: snapshot.data!.docs[index].data(),
                                );
                              } else if (!snapshot.hasData) {
                                return const Center(
                                    child: Text(
                                  "No Orders",
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(246, 152, 152, 152)),
                                ));
                              } else if (snapshot.hasError) {
                                return Center(
                                  child: Text("Some Error occured",
                                      style: TextStyle(fontSize: 20)),
                                );
                              } else
                                return Container();
                            });
                      },
                    ))
                  ],
                ),
              ))
            ],
          )),
    );
  }
}
