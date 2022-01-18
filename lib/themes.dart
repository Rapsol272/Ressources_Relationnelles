import 'package:flutter/material.dart';
import 'package:flutter_firebase/common/constants.dart';

class MyThemes {
  static final primaryColor = customColor;

  static final darkTheme = ThemeData(
    primaryColorDark: primaryColor,
    dividerColor: Colors.white,
  );

  static final lightTheme = ThemeData(
    primaryColor: primaryColor,
    dividerColor: Colors.black,
  );
}
