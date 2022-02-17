import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
const or = Color(0xffFABD5A);

String convertDateTimeDisplay(String date) {
  final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
  final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
  final DateTime displayDate = displayFormater.parse(date);
  final String formatted = serverFormater.format(displayDate);
  return formatted;
}

unitTags(List array, int i) {
  return Flexible(
    child: Container(
      margin: const EdgeInsets.only(right: 3, left: 3),
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
          bottomLeft: Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            greenMajor,
            Color(0xffaefea01),
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            array[i],
            style: TextStyle(
              color: Colors.white,
              fontSize: 8,
            ),
          ),
        ],
      ),
    ),
  );
}

var textInputDecoration = InputDecoration(
  fillColor: Colors.white30,
  filled: true,
  contentPadding: EdgeInsets.all(5.0),
  errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 1.0),
      borderRadius: BorderRadius.circular(40)),
  focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 1.0),
      borderRadius: BorderRadius.circular(40)),
  enabledBorder: UnderlineInputBorder(),
  focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: or, width: 1.0),
      borderRadius: BorderRadius.circular(40)),
);

var textOutlineDecoration = InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: or, width: 1.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: greenMajor, width: 1.0),
    ));

final ButtonStyle outlineButtonStyle = OutlinedButton.styleFrom(
  primary: Colors.red,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);
