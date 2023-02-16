import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fooddelivery/commponents/bottomnav.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import '../provider/themeprovider.dart';
import '../service/firestore.dart';
import '../utils/colors.dart';
import '../utils/utilil.dart';

class FinalOrder extends StatefulWidget {
  final snapusername, latit, long;
  const FinalOrder({Key? key, this.latit, this.long, this.snapusername})
      : super(key: key);

  @override
  State<FinalOrder> createState() => _FinalOrderState();
}

class _FinalOrderState extends State<FinalOrder>
    with SingleTickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final geo = Geoflutterfire();
  bool isLoading = true;
  List<String> title = [];
  List<String> unitPrice = [];
  List<int> quantity = [];
  List<String> photUrl = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark =
        Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
            ? "dark"
            : "light";
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('user')
          .doc(_auth.currentUser!.uid)
          .collection('cart')
          .snapshots(), //get all data and streambuilder used as as real time
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.maincolor,
            ),
          );
        }
        if (!snapshot.hasData) {
          return const Center(
              child: Text(
            "user not found",
            style: TextStyle(color: Color.fromARGB(184, 138, 138, 138)),
          ));
        }
        if (snapshot.hasError) {
          return Center(
              child: Text(
            "Unabel to get user data",
            style: TextStyle(color: Color.fromARGB(184, 138, 138, 138)),
          ));
        } else if (snapshot.hasData) {
          for (var i = 0; i < snapshot.data!.docs.length; i++) {
            title.add(snapshot.data!.docs[i].data()['title']);
            unitPrice.add(snapshot.data!.docs[i].data()['unitprice']);
            quantity.add(snapshot.data!.docs[i].data()['quantity']);
            photUrl.add(snapshot.data!.docs[i].data()['photoUrl']);
          }
          makeOrder();
          return Container();
        } else {
          return Container();
        }
      },
    ));
  }

  void makeOrder() async {
    try {
      String res = await FireStoreMethods().makeOrder(
          widget.snapusername['username'],
          title,
          unitPrice,
          quantity,
          'payPal',
          true,
          photUrl,
          geo.point(latitude: widget.latit, longitude: widget.long));

      if (res == 'success') {
        setState(() {
          isLoading = false;
        });

        FireStoreMethods().removeCart('');
        Get.offAllNamed('/');
        Get.snackbar("", "",
            borderWidth: 2,
            borderColor: Colors.green,
            backgroundColor: Color.fromARGB(149, 255, 255, 255),
            titleText: const Text(
              'Dliverd',
              style: TextStyle(
                  color: Color.fromARGB(255, 67, 67, 66),
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            messageText: const Text(
              'Order is Successfully Dliverd',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
            icon: const Icon(
              FontAwesomeIcons.check,
              color: Colors.green,
            ),
            margin: const EdgeInsets.only(top: 12));
      } else {
        setState(() {
          isLoading = false;
        });
        Utils.showSnackBar(res);
      }
    } catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }
}
