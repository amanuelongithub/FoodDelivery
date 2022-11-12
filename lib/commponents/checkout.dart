import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fooddelivery/screen/address_screen.dart';
import 'package:provider/provider.dart';
import '../provider/themeprovider.dart';
import '../utils/colors.dart';
import 'package:get/get.dart';

class CheckOut extends StatefulWidget {
  final bool isEmpty;
  CheckOut({
    Key? key,
    required this.isEmpty,
  }) : super(key: key);

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut>
    with SingleTickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final isDark =
        Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
            ? "dark"
            : "light";

    var total;
    return Container(
      alignment: Alignment.bottomCenter,
      width: double.infinity,
      height: 80,
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
          color:
              isDark == "dark" ? Color.fromARGB(255, 68, 68, 68) : Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          )),
      child: Center(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('user')
                .doc(_auth.currentUser!.uid)
                .collection('cart')
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                isLoading = !isLoading;
                return SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: AppColors.maincolor,
                    strokeWidth: 3,
                  ),
                );
              } else {
                isLoading = !isLoading;
                total = 0;
                snapshot.data.docs.forEach((result) {
                  total += int.parse((result.data()['unitprice'])) *
                      result.data()['quantity'];
                });
                return RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: total.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      color: isDark == "dark" ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: "  Birr",
                    style: TextStyle(
                      fontSize: 20,
                      color: isDark == "dark" ? Colors.white : Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ]));
              }
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9), // <-- Radius
                ),
                onPrimary: Colors.black38,
                primary: AppColors.maincolor,
                shadowColor: Colors.transparent,
                minimumSize: Size(150, 45)),
            onPressed: () {
              if (widget.isEmpty == true && total == 0) {
                Get.snackbar("", "",
                    borderWidth: 2,
                    borderColor: Colors.amber,
                    dismissDirection: DismissDirection.horizontal,
                    backgroundColor: Color.fromRGBO(255, 255, 255, 0.885),
                    titleText: Text(
                      'Empty !',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    messageText: Text(
                      'cart is empty',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                    margin: EdgeInsets.only(top: 12));
              } else if (widget.isEmpty == false && total > 10)
                Get.to(() => AddressScreen());
            },
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.black,
                      strokeWidth: 3,
                    ),
                  )
                : const Text(
                    "Check Out",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
          )
        ]),
      ),
    );
  }
}
