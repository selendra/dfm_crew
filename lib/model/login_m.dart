import 'package:flutter/material.dart';

class LoginModel {

  Map<String, dynamic>? decode;

  TextEditingController email = TextEditingController();
  TextEditingController pwd = TextEditingController();

  FocusNode emailNode = FocusNode();
  FocusNode pwdlNode = FocusNode();

  bool? isShow = false;
}