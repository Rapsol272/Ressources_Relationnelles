import 'package:flutter/material.dart';

Map<int, Color> colorCodes = {
  50: Color.fromRGBO(147, 205, 72, .1),
  100: Color.fromRGBO(147, 205, 72, .2),
  200: Color.fromRGBO(147, 205, 72, .3),
  300: Color.fromRGBO(147, 205, 72, .4),
  400: Color.fromRGBO(147, 205, 72, .5),
  500: Color.fromRGBO(147, 205, 72, .6),
  600: Color.fromRGBO(147, 205, 72, .7),
  700: Color.fromRGBO(147, 205, 72, .8),
  800: Color.fromRGBO(147, 205, 72, .9),
  900: Color.fromRGBO(147, 205, 72, 1),
};

MaterialColor customColor = MaterialColor(0xff03989E, colorCodes);

const greenMajor = Color(0xff03989E);
const or =  Color(0xffFABD5A);

var textInputDecoration = InputDecoration(
  fillColor: Colors.white30,
  filled: true,
  contentPadding: EdgeInsets.all(5.0),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color:Colors.red, width:1.0),
    borderRadius: BorderRadius.circular(40)
  ),
  focusedErrorBorder: UnderlineInputBorder(
    borderSide: BorderSide(color:Colors.red, width:1.0),
    borderRadius: BorderRadius.circular(40)
  ),
  enabledBorder: UnderlineInputBorder(
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color:or, width:1.0),
    borderRadius: BorderRadius.circular(40)
  ),
);

final ButtonStyle outlineButtonStyle = OutlinedButton.styleFrom(
  primary: Colors.red,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
  );