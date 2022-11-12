import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';
import '../service/authe_methode.dart';

class UserProvider extends ChangeNotifier {
  late User? _user;
  final AuthMethods _authMethods = AuthMethods();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
    
  }
}
