import 'package:flutter/material.dart';
import 'package:flutter_firebase/common/constants.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    leading: IconButton(
      icon: Icon(Icons.arrow_back_ios, color: greenMajor),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [],
  );
}
