import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String? fullName;
  final String? username;
  final String? phoneNum;
  final String? email;
  final String? uid;
  final String? userProfile;
  final List? cart;
  final List? history;

  const User({
    this.fullName,
    this.username,
    this.phoneNum,
    this.email,
    this.uid,
    this.userProfile,
    this.cart,
    this.history,
  });
// full name:- user can modify after signup
  Map<String, dynamic> toJson() => {
        "fullName": fullName??'',
        "username": username,
        "phoneNum": phoneNum,
        "uid": uid,
        "email": email,
        "userProfile": userProfile?? '',
        "cart": cart,
        "history": history,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      fullName: snapshot['fullName'],
      username: snapshot['username'],
      phoneNum: snapshot['phoneNum'],
      email: snapshot['email'],
      uid: snapshot['uid'],
      userProfile: snapshot['userProfile'],
      cart: snapshot['cart'],
      history: snapshot['history'],
    );
  }
}
