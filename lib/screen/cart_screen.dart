import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/components/cart_card.dart';
import 'package:fooddelivery/components/checkout.dart';
import 'package:fooddelivery/service/firestore.dart';
import 'package:fooddelivery/utils/colors.dart';
import 'package:fooddelivery/utils/utils.dart';
import '../provider/themeprovider.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark =
        Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
            ? "dark"
            : "light";

    final FirebaseAuth _auth = FirebaseAuth.instance;

    return Scaffold(
      backgroundColor:
          isDark == "dark" ? null : Color.fromARGB(255, 231, 231, 231),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 40, left: 15, bottom: 15, right: 15),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  color: isDark == "dark" ? Colors.white : Colors.black54,
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Get.back();
                  },
                ),
                Text(
                  "Cart",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                )
              ],
            ),
            Divider(
              color: Color.fromARGB(255, 136, 136, 136),
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('user')
                    .doc(_auth.currentUser!.uid)
                    .collection('cart')
                    .snapshots(), //get all data and streambuilder used as as real time
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
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
                      "Cart is Empty",
                      style:
                          TextStyle(color: Color.fromARGB(184, 138, 138, 138)),
                    ));
                  }
                  if (snapshot.hasError) {
                    return Center(
                        child: Text(
                      "Unabel to get the data",
                      style:
                          TextStyle(color: Color.fromARGB(184, 138, 138, 138)),
                    ));
                  }

                  return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        if (snapshot.hasData) {
                          return CartCard(
                            snap: snapshot.data!.docs[index].data(),
                          );
                        } else if (!snapshot.hasData) {
                          return const Center(
                              child: Text(
                            "Cart is Empty",
                            style: TextStyle(
                                color: Color.fromARGB(246, 152, 152, 152)),
                          ));
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text("Some error occured",
                                style: TextStyle(fontSize: 20)),
                          );
                        } else
                          return Container();
                      });
                },
              ),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('user')
                  .doc(_auth.currentUser!.uid)
                  .collection('cart')
                  .snapshots(), //get all data and streambuilder used as as real time
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 38.0),
                      child: Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: AppColors.maincolor,
                          ),
                        ),
                      ),
                    );
                  }
                }
                if (snapshot.data!.docs.isEmpty) {
                  return CheckOut(isEmpty: true);
                } else {
                  if (snapshot.hasData) {
                    print('has data');
                    return CheckOut(isEmpty: false);
                  } else {
                    return Container();
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
