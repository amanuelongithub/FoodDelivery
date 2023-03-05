import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fooddelivery/components/checkout.dart';
import 'package:fooddelivery/utils/colors.dart';
import 'package:provider/provider.dart';

import '../provider/themeprovider.dart';

class HistoryCard extends StatefulWidget {
  // final snap;

  HistoryCard({
    Key? key,
    /*this.snap*/
  }) : super(key: key);

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  TextEditingController reviewController = TextEditingController();
  // late String username;
  // late List getTitle;
  // late List unitPrice;
  // late String payMethod;
  // late bool payStatus;
  // late List photUrl;
  // late var title;

  @override
  void initState() {
    super.initState();
    // getTitle = widget.snap['title'];
    // title = getTitle.join(' , ');
    // photUrl = widget.snap['photoUrl'];
    // payStatus = widget.snap['payStatus'];
    // payMethod = widget.snap['payMethods'];
  }

  @override
  Widget build(BuildContext context) {
    final isDark =
        Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
            ? "dark"
            : "light";
    final inputBorder = OutlineInputBorder(
        borderSide: Divider.createBorderSide(context),
        borderRadius: BorderRadius.circular(10));
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3.6,
      margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
      decoration: BoxDecoration(
          color:
              isDark == "dark" ? Color.fromARGB(221, 49, 49, 49) : Colors.white,
          boxShadow: [
            BoxShadow(
              color: isDark == "dark"
                  ? Color.fromARGB(137, 89, 89, 89)
                  : Colors.grey.withOpacity(0.4),
              offset: const Offset(10, 10),
              blurRadius: 20,
            ),
          ],
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 20,
                    bottom: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Food name :",
                            style: TextStyle(
                                color: AppColors.maincolor,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                          Text("Burger",
                              // title,

                              maxLines: 2,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                fontSize: 16,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Price : ",
                            style: TextStyle(
                                color: AppColors.maincolor,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.7,
                            padding: EdgeInsets.only(left: 2),
                            child: Text(
                                // ' ${widget.snap['totalprice'].toString()}',
                                "300",
                                style: TextStyle(
                                  fontSize: 16,
                                )),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Pay status : ",
                            style: TextStyle(
                                color: AppColors.maincolor,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    // payStatus ? "Payed" :
                                    "UnPayed",
                                    style: TextStyle(
                                      fontSize: 16,
                                    )),
                                Image.asset(
                                  'assets/img/paypal2.png',
                                  width: 80,
                                  height: 30,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Raite order : ",
                            style: TextStyle(
                                color: AppColors.maincolor,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(left: 10),
                              height: 30,
                              child: FittedBox(
                                child: RatingBar(
                                    glow: false,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    initialRating: 2.5,
                                    ratingWidget: RatingWidget(
                                        full: Icon(
                                          Icons.star,
                                          size: 10,
                                          color: Colors.amber,
                                        ),
                                        half: Icon(
                                          Icons.star_half,
                                          size: 10,
                                          color: Colors.amber,
                                        ),
                                        empty: Icon(
                                          Icons.star_border_outlined,
                                          size: 10,
                                          color: Colors.amber,
                                        )),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ))),
          // SizedBox(
          //   height: 355,
          //   child: ExpansionTile(
          //     iconColor: AppColors.maincolor,
          //     title: Text(
          //       "Foods",
          //       style: TextStyle(
          //           color: AppColors.maincolor, fontWeight: FontWeight.bold),
          //     ),
          //     children: [
          //       TextFormField(
          //         controller: reviewController,
          //         showCursor: true,
          //         cursorColor: Color.fromARGB(255, 126, 126, 126),
          //         enableInteractiveSelection: true,
          //         maxLines: 8,
          //         decoration: InputDecoration(
          //           hintText: "Write caption",
          //           hintStyle: TextStyle(
          //               color: Color.fromARGB(255, 126, 126, 126),
          //               fontWeight: FontWeight.bold),
          //           border: inputBorder,
          //           focusedBorder: OutlineInputBorder(
          //             borderSide: BorderSide(color: Colors.grey, width: 2.0),
          //             borderRadius: BorderRadius.circular(10.0),
          //           ),
          //         ),
          //         keyboardType: TextInputType.text,
          //         obscureText: false,
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
