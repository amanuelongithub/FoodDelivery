// import 'dart:ffi';

// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fooddelivery/model/order.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:uuid/uuid.dart';
import 'package:get/get.dart';
import '../model/cart.dart';
import 'package:collection/collection.dart';

final List<double> totPrice = [0.00];
calctotal(List<int> quantity, List<String> unitprice) {
  for (var i = 0; i < quantity.length; i++) {
    int sum = quantity[i] * int.parse(unitprice[i]);
    totPrice.add(sum.toDouble());
    // totPrice.fold(totPrice[0], (previousValue, element) {});
  }
  double total = totPrice.sum;

  return total;
}

class FireStoreMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<String> makeOrder(
    String username,
    List<String> title,
    List<String> unitPrice,
    List<int> quantity,
    String payMethods,
    bool payStatus,
    List<String> photoUrl,
    GeoFirePoint userLocation,
  ) async {
    String res = "Something error occured";

    try {
      String orderId = const Uuid().v1();
    

      Order order = Order(
        orderId: orderId,
        username: username,
        title: title,
        quantity: quantity,
        orderStatus: 'pending',
        payMethods: payMethods,
        payStatus: payStatus,
        totalprice: calctotal(quantity, unitPrice),
        uid: _auth.currentUser!.uid,
        unitprice: unitPrice,
        userLocation: userLocation,
        photoUrl: photoUrl,
        datePublished: DateTime.now(),
      );

      _firebaseFirestore
          .collection('orders')
          .doc(_auth.currentUser!.uid)
          .set(order.toJson());

      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> addtoCart(
    String title,
    String content,
    int quantity,
    String unitprice,
    String postId,
    String postUrl,
  ) async {
    String res = "Something error occured";

    try {
      // checkIfExsit();

      String cartId = const Uuid().v1();

      Cart cart = Cart(
        title: title,
        content: content,
        unitprice: unitprice,
        cartId: cartId,
        postId: postId,
        photoUrl: postUrl,
        quantity: quantity,
        uid: _auth.currentUser!.uid,
      );
      DocumentSnapshot snap = await _firebaseFirestore
          .collection('user')
          .doc(_auth.currentUser!.uid)
          .collection('cart')
          .doc(postId)
          .get();

      if (snap.exists) {
        Get.snackbar("", "",
            backgroundColor: Color.fromARGB(149, 255, 255, 255),
            titleText: const Text(
              'It\'s Oready there',
              style: TextStyle(
                  color: Color.fromARGB(255, 67, 67, 66),
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            messageText: const Text(
              'the item is exist in the cart',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
            margin: const EdgeInsets.only(top: 12));
      } else {
        _firebaseFirestore
            .collection('user')
            .doc(_auth.currentUser!.uid)
            .collection('cart')
            .doc(postId)
            .set(cart.toJson());
      }

      // await _firebaseFirestore
      //     .collection('user')
      //     .doc(_auth.currentUser!.uid)
      //     .update({
      //   'cart': FieldValue.arrayUnion([postId])
      // });

      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> removeCart(String postId) async {
    String res = "Some error ocured";
    try {
      var collection;

      if (postId != '') {
        await _firebaseFirestore
            .collection('user')
            .doc(_auth.currentUser!.uid)
            .collection('cart')
            .doc(postId)
            .delete();
        // await _firebaseFirestore
        //     .collection('user')
        //     .doc(_auth.currentUser!.uid)
        //     .update({
        //   'cart': FieldValue.arrayRemove([postId])
        // });
      } else {
        collection = FirebaseFirestore.instance
            .collection('user')
            .doc(_auth.currentUser!.uid)
            .collection('cart');
        var snapshots = await collection.get();
        for (var doc in snapshots.docs) {
          await doc.reference.delete();
        }

        // await _firebaseFirestore
        //     .collection('user')
        //     .doc(_auth.currentUser!.uid)
        //     .update({'cart': []});
      }

      res = "success";
    } catch (e) {
      print(e.toString());
    }
    return res;
  }

  // Future<List> getLists() async {

  //   return cartList;
  // }
/*
  checkIfExsit() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

    try {
      List<String> cartList = [];
      CollectionReference col_ref = _firebaseFirestore
          .collection('user')
          .doc(_auth.currentUser!.uid)
          .collection('cart');

      QuerySnapshot docSnap = await col_ref.get();
      docSnap.docs.forEach((element) {
        cartList.add(element.id);
      });

      if (cartList.isNotEmpty) {
        // for (int i = 0; i < cartList.length; i++) {
        var collectionRef = _firebaseFirestore
            .collection('user')
            .where('cart', arrayContains: cartList[1])
            .get()
            .then((value) {
          if (value.docs.isEmpty) {
            print("there is no food with this id");
          } else if (value.docs.isNotEmpty) {
            print('it has a food with this id\n${value.docs.first}');
          } else {
            print('boooooooooooooooooommmmmmmmmmmmmmm');
          }
        });
        // }
      } else {
        print('cart is Empty');
      }

      // return doc.exists;
    } catch (e) {
      Utils.showSnackBar(e.toString());
      throw e;
    }
  }
*/
}
