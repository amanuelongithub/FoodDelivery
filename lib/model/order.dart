import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class Order {
  final String orderId;
  final String uid;
  final String username;
  final List<String> title;

  final List<int> quantity;
  final List<String> unitprice;
  final double totalprice;
  final String payMethods;

  final bool payStatus;
  final String? orderStatus;
  final GeoFirePoint userLocation;
  final List<String> photoUrl;
  final DateTime datePublished;

  const Order({
    required this.orderId,
    required this.uid,
    required this.username,
    required this.title,
    required this.quantity,
    required this.unitprice,
    required this.totalprice,
    required this.payMethods,
    required this.payStatus,
    this.orderStatus,
    required this.userLocation,
    required this.photoUrl,
    required this.datePublished,
  });

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "uid": uid,
        "username": username,
        "title": title,
        "quantity": quantity,
        "unitprice": unitprice,
        "totalprice": totalprice,
        "payMethods": payMethods,
        "payStatus": payStatus,
        "orderStatus": orderStatus,
        "userLocation": userLocation.data,
        "photoUrl": photoUrl,
        "datePublished": datePublished,
      };

  static Order fromSnap(Map<String, dynamic> snapshot) {
    // var snapshot = snap.data() as Map<String, dynamic>;
    GeoPoint p1 = snapshot['userLocation']['geopoint'] as GeoPoint;
    GeoFirePoint p2 = GeoFirePoint(p1.latitude, p1.longitude);

    return Order(
      orderId: snapshot['orderId'],
      uid: snapshot['uid'],
      username: snapshot['username'],
      title: snapshot['title'],
      quantity: snapshot['quantity'],
      unitprice: snapshot['unitprice'],
      totalprice: snapshot['totalprice'],
      payMethods: snapshot['payMethods'],
      payStatus: snapshot['payStatus'],
      orderStatus: snapshot['orderStatus'],
      userLocation: p2,
      photoUrl: snapshot['photoUrl'],
      datePublished: (snapshot['datePublished'] as Timestamp).toDate(),
    );
  }
}
