import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/home/home_screen.dart';
import 'package:flutter_firebase/screens/pages/profil/profil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter_firebase/screens/pages/postHelper.dart';
import 'package:flutter_firebase/screens/pages/postItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/common/constants.dart';
import 'package:flutter_firebase/common/constants.dart';

class commentPage extends StatefulWidget {
  commentPage({Key? key}) : super(key: key);

  @override
  _commentPageState createState() => _commentPageState();
}

class _commentPageState extends State<commentPage> {
  final List messages = [
    {
      'senderName': 'Laurèna',
      'message': 'AAAAAHHHH',
      'unRead': 2,
      'date': '16:35'
    },
    {'senderName': 'Max', 'message': 'OOOOAHHHH', 'unRead': 0, 'date': '18:60'},
    {
      'senderName': 'Alla',
      'message': 'Je te pète le F**K bg',
      'unRead': 4,
      'date': '22:13'
    },
    {
      'senderName': 'Sabrina',
      'message': 'Flutter love you',
      'unRead': 11,
      'date': '22:15'
    },
    {
      'senderName': 'Laurèna',
      'message': 'AAAAAHHHH',
      'unRead': 14,
      'date': '16:35'
    },
    {
      'senderName': 'Max',
      'message': 'OOOOAHHHH',
      'unRead': 12,
      'date': '18:60'
    },
    {
      'senderName': 'Alla',
      'message': 'Je te pète le F**K bg',
      'unRead': 0,
      'date': '22:13'
    },
    {
      'senderName': 'Sabrina',
      'message': 'Flutter love you',
      'unRead': 0,
      'date': '22:15'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: or,
    );
  }
}
