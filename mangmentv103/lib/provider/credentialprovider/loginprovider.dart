import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  UserData? _userData;

  List<UserData> allDetails = [];

  UserData? get userdata => _userData;

  void setUserregter(UserData userdata) {
    _userData = userdata;
    allDetails.add(userdata);

    notifyListeners();
  }
}

class UserData {
  String email;
  String password;
  String? name;
  int? designation;
  int? empid;
  String userType;

  UserData({
    this.name,
    required this.email,
    required this.password,
    this.designation,
    this.empid,
    required this.userType
  });
}
