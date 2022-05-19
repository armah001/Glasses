import 'package:flutter/material.dart';

class UserModel {
  String userName, userEmail, userPhoneNumber, userImage;
  UserModel(
      {required this.userEmail,
      required this.userImage,
      required this.userName,
      required this.userPhoneNumber});
}
