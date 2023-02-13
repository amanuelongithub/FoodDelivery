import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/commponents/checkout.dart';
import 'package:fooddelivery/utils/colors.dart';
import 'package:provider/provider.dart';

import '../provider/themeprovider.dart';

class OrderCard extends StatefulWidget {
  final snap;

  OrderCard({Key? key, this.snap}) : super(key: key);

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  late String username;
  late List getTitle;
  late List unitPrice;
  late String payMethod;
  late bool payStatus;
  late List photUrl;
  late var title;

  @override
  void initState() {
    super.initState();
    getTitle = widget.snap['title'];
    title = getTitle.join(' , ');
    photUrl = widget.snap['photoUrl'];
    payStatus = widget.snap['payStatus'];
    payMethod = widget.snap['payMethods'];
  }

  @override
  Widget build(BuildContext context) {
    final isDark =
        Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
            ? "dark"
            : "light";
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3.7,
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
              child: Container(
                  width: double.maxFinite,
                  height: MediaQuery.of(context).size.width / 6,
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
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: Text(title.toString(),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
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
                            child:
                                Text(' ${widget.snap['totalprice'].toString()}',
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
                                Text(payStatus ? "Payed." : "UnPayed",
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
                    ],
                  ))), /*
          ExpansionTile(
            iconColor: AppColors.maincolor,
            title: Text(
              "Foods",
              style: TextStyle(
                  color: AppColors.maincolor, fontWeight: FontWeight.bold),
            ),
            children: [
              Container(
                height: 140,
                width: MediaQuery.of(context).size.width / 1.6,
                child: GridView.count(
                  physics: const BouncingScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 10,
                  children: List.generate(
                      photUrl.length,
                      (index) => Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: isDark == 'dark'
                                        ? Color.fromARGB(215, 255, 255, 255)
                                        : Colors.black38),
                                color: isDark == "dark"
                                    ? Color.fromARGB(221, 49, 49, 49)
                                    : Colors.white,
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
                            child: Image.network(
                              photUrl[index],
                              width: 80,
                              height: 80,
                            ),
                          )),
                ),
              )
            ],
          )
      */
        ],
      ),
    );
  }
}
