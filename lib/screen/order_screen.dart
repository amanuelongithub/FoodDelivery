import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/components/history_card.dart';
import 'package:fooddelivery/utils/colors.dart';
import '../components/order_card.dart';
import '../provider/themeprovider.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class OrderScreen extends StatefulWidget {
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int _selectedPage = 0;
  late PageController _pageController;

  void _changePage(int pageNum) {
    setState(() {
      _selectedPage = pageNum;
      _pageController.animateToPage(pageNum,
          duration: Duration(milliseconds: 500),
          curve: Curves.fastLinearToSlowEaseIn);
    });
  }

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark =
        Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
            ? "dark"
            : "light";

    final FirebaseAuth _auth = FirebaseAuth.instance;

    return Scaffold(
        appBar: AppBar(
          leading: null,
          shadowColor: Colors.transparent,
          backgroundColor:
              isDark == "dark" ? null : Color.fromARGB(255, 231, 231, 231),
          title: Text("  Your order",
              style: TextStyle(
                fontSize: 18,
                color: isDark == "dark"
                    ? Color.fromARGB(255, 231, 231, 231)
                    : Color.fromARGB(255, 38, 38, 38),
                fontWeight: FontWeight.bold,
              )),
        ),
        backgroundColor:
            isDark == "dark" ? null : Color.fromARGB(255, 231, 231, 231),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 0, left: 15, bottom: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('orders')
                            .where('uid', isEqualTo: _auth.currentUser!.uid)
                            .get(),
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
                              "There is no Order",
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
                                  return OrderCard(
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
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
/*
class TabButton extends StatelessWidget {
  final String text;
  final int selectedPage;
  final int pageNumber;
  final VoidCallback onPressed;

  const TabButton(
      {Key? key,
      required this.text,
      required this.selectedPage,
      required this.pageNumber,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        decoration: BoxDecoration(
          color: selectedPage == pageNumber
              ? Color.fromARGB(205, 255, 208, 1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        width: MediaQuery.of(context).size.width / 2.4,
        padding: EdgeInsets.symmetric(
            vertical: selectedPage == pageNumber ? 12.0 : 0,
            horizontal: selectedPage == pageNumber ? 20.0 : 0),
        margin: EdgeInsets.symmetric(
            vertical: selectedPage == pageNumber ? 0 : 12.0,
            horizontal: selectedPage == pageNumber ? 0 : 2.0),
        duration: Duration(milliseconds: 900),
        curve: Curves.fastLinearToSlowEaseIn,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18,
              fontWeight: selectedPage == pageNumber
                  ? FontWeight.w800
                  : FontWeight.normal,
              color: selectedPage == pageNumber
                  ? Color.fromARGB(189, 0, 0, 0)
                  : Color.fromARGB(255, 135, 135, 135)),
        ),
      ),
    );
  }

}
*/