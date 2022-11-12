import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String username;
  final String phoneNum;
  final String email;
  final String uid;
  final List cart;
  final List history;

  const User({
    required this.username,
    required this.phoneNum,
    required this.email,
    required this.uid,
    required this.cart,
    required this.history,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "phoneNum": phoneNum,
        "uid": uid,
        "email": email,
        "cart": cart,
        "history": history,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot['username'],
      phoneNum: snapshot['phoneNum'],
      uid: snapshot['uid'],
      email: snapshot['email'],
      cart: snapshot['cart'],
      history: snapshot['history'],
    );
  }
}
