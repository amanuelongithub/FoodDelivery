import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fooddelivery/model/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('user').doc(currentUser.uid).get();
    return model.User.fromSnap(snap);
  }

  Future<String> signUpUser({
    required String email,
    required String phoneNum,
    required String username,
    required String password,
  }) async {
    String res = "Some error ocurred";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        model.User user = model.User(
            username: username,
            phoneNum: phoneNum,
            email: email,
            uid: cred.user!.uid,
            cart: [],
            history: []
            );
        await _firestore
            .collection("user")
            .doc(cred.user!.uid)
            .set(user.toJson());
        res = "success";
      }
    } catch (e) {}

    return res;
  }
  
  getUsername() {

  }
}
