
import 'package:flutter/material.dart';
import 'package:riverpod/model/user.dart';
import 'package:riverpod/resources/auth_methods.dart';

class UserProvider with ChangeNotifier{

  User? _user;

  final AuthMethods _authMethods=AuthMethods();

  User get getUser=> _user!;
  

  Future<void> refresUser()async{
    User user=await _authMethods.getUserDetails();
   _user=user;
   notifyListeners();
  }
}