import 'package:cloud_firestore/cloud_firestore.dart';

class Cart {
  final String uid;
  final String title;
  final String content;
  final int quantity;
  final String unitprice;
  final String postId;
  final String photoUrl;
  final cartId;

  const Cart({
    required this.uid,
    required this.title,
    required this.content,
    required this.quantity,
    required this.unitprice,
    required this.postId,
    required this.photoUrl,
    this.cartId,
  });

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "title": title,
        "content": content,
        "quantity": quantity,
        "unitprice": unitprice,
        "postId": postId,
        "photoUrl": photoUrl,
        "cartId": cartId,
      };

  static Cart fromSnap(Map<String, dynamic> snapshot) {
    // var snapshot = snap.data() as Map<String, dynamic>;
    print('Hello wprld 2');
    return Cart(
      uid: snapshot['uid'],
      title: snapshot['title'],
      content: snapshot['content'],
      quantity: snapshot['quantity'],
      unitprice: snapshot['unitprice'],
      postId: snapshot['postId'],
      photoUrl: snapshot['photoUrl'],
      cartId: snapshot['cartId'],
    );
  }
}
