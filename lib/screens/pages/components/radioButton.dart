import 'package:flutter/material.dart';

int value = 0;
// ignore: non_constant_identifier_names
Widget CustomRadioButton(String text, int index) {
  return OutlinedButton(
    style: OutlinedButton.styleFrom(
      shape: StadiumBorder(),
      side: BorderSide(width: 2, color: Colors.red),
    ),
    onPressed: () {},
    child: Text(
      text,
      style: TextStyle(
        color: (value == index) ? Colors.green : Colors.black,
      ),
    ),
  );
}
