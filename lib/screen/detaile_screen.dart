import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fooddelivery/service/firestore.dart';
import 'package:fooddelivery/utils/utilil.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import '../../provider/themeprovider.dart';
import '../../utils/colors.dart';
import '../commponents/cart_button.dart';
import 'feed_screen.dart';
import 'package:lottie/lottie.dart';

class DetailPage extends StatefulWidget {
  final String postId;
  final String title;
  final String content;
  final String description;
  final String photoUrl;
  final String price;
  const DetailPage(
      {Key? key,
      required this.photoUrl,
      required this.title,
      required this.content,
      required this.description,
      required this.price,
      required this.postId})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  // bool isIncrement = false;

  int quantity = 1;
  bool isLoading = false;

  void addToCart() async {
    setState(() {
      isLoading = true;
    });
    try {
      String res = await FireStoreMethods().addtoCart(
        widget.title,
        widget.content,
        quantity,
        widget.price,
        widget.postId,
        widget.photoUrl,
      );
      if (res == 'success') {
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        Get.snackbar("", "",
            borderWidth: 2,
            borderColor: Colors.black,
            dismissDirection: DismissDirection.horizontal,
            backgroundColor: Color.fromRGBO(255, 255, 255, 0.885),
            titleText: Text(
              'Please check your Internet Connection',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            messageText: Text(
              '____________________________',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
            margin: EdgeInsets.only(top: 12));
      }
    } catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    void setQuantity(bool isIncrement) {
      if (isIncrement) {
        if (quantity >= 7) {
          quantity = 7;
        } else
          quantity += 1;
      } else {
        if (quantity < 2) {
          quantity = 1;
        } else {
          quantity -= 1;
        }
      }
    }

    void checkQuantitiy(int quantity) {
      if (quantity < 0) {
        // no food
      } else if (quantity > 12) {
        //You have choose max order
      }
    }

    final isDark =
        Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
            ? "dark"
            : "light";

    return Scaffold(
      backgroundColor:
          isDark == "dark" ? null : const Color.fromARGB(255, 231, 231, 231),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child:
                  ListView(physics: NeverScrollableScrollPhysics(), children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        color: isDark == "dark" ? Colors.white : Colors.black54,
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Get.back(result: () => FeedScreen());
                        },
                      ),
                      const Cart()
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 150,
                                child: Text(
// "                                  ??????????????????????????????????????????????????????????????????",
                                  widget.title,
                                  maxLines: 3,
                                  overflow: TextOverflow.fade,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                              ),
                              Text(widget.content,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w100,
                                      fontSize: 20)),
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                "Birr",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 20),
                              ),
                              Text(widget.price.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25)),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 100,
                            height: 30,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 6,
                                itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 18,
                                    )),
                          ),
                          Text(
                            " (270 Review)",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Hero(
                        tag: widget.postId,
                        child: SizedBox(
                            width: double.infinity,
                            child: CachedNetworkImage(
                              imageUrl: widget.photoUrl,
                              fit: BoxFit.contain,
                              width: double.infinity,
                              height: 220,
                            )),
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      Container(
                        height: 200,
                        child: ListView(
                          children: [
                            Text(
                              "About the Food",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 13, vertical: 5),
                              child: Text(
                                widget.description,
                                textAlign: TextAlign.left,
                                maxLines: 10,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: isDark == "dark"
                                        ? AppColors.maincolor
                                        : const Color.fromARGB(255, 84, 84, 84),
                                    fontSize: 19),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      splashColor: const Color.fromARGB(255, 211, 161, 12),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      onTap: () {
                        setState(() {
                          setQuantity(false);
                        });
                      },
                      child: Ink(
                        child: Container(
                            width: 55,
                            height: 45,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                )),
                            child: const Center(
                                child: Text(
                              "-",
                              style: TextStyle(fontSize: 35),
                            ))),
                      ),
                    ),
                    Container(
                      // margin: EdgeInsets.only(bottom: 20),
                      width: 55,
                      height: 45,
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      )),
                      child: Center(
                          child: Text(
                        quantity.toString(),
                        style: const TextStyle(
                          fontSize: 25,
                        ),
                      )),
                    ),
                    InkWell(
                      splashColor: Color.fromARGB(255, 211, 161, 12),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      onTap: () {
                        setState(() {
                          setQuantity(true);
                        });
                      },
                      child: Ink(
                        child: Container(
                            width: 55,
                            height: 45,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                )),
                            child: const Center(
                                child: Text(
                              "+",
                              style: TextStyle(fontSize: 40),
                            ))),
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: isLoading
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(9), // <-- Radius
                              ),
                              onPrimary: Colors.black38,
                              primary: AppColors.maincolor,
                              shadowColor: Colors.transparent,
                              minimumSize: Size(145, 44)),
                          onPressed: () {},
                          child: const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.black,
                              strokeWidth: 3,
                            ),
                          ),
                        )
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(9), // <-- Radius
                              ),
                              onPrimary: Colors.black38,
                              primary: AppColors.maincolor,
                              shadowColor: Colors.transparent,
                              minimumSize: Size(145, 44)),
                          onPressed: () async {
                            addToCart();
                          },
                          child: Row(
                            children: [
                              const Text(
                                "Add to",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              SvgPicture.asset(
                                "assets/img/shopping-cart-outline.svg",
                                width: 25,
                                height: 25,
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
