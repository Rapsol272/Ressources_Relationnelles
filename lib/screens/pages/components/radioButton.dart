import 'package:flutter/material.dart';
import '../../../common/constants.dart';

int value = 0;
Widget CustomRadioButton(String text, int index){
      return OutlinedButton(
        style:OutlinedButton.styleFrom(
    shape: StadiumBorder(),
    side: BorderSide(
      width: 2,
      color: Colors.red
    ),
  ),
        onPressed: (){
          
      },
      child: Text(
        text,
        style: TextStyle(
          color: (value == index) ? Colors.green  : Colors.black,
        ),
      ),
     
      );
  }