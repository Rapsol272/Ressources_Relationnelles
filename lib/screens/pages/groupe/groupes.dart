import 'package:flutter/material.dart';
import 'package:flutter_firebase/common/constants.dart';

import 'package:flutter_firebase/screens/pages/groupe/bodyGroupes.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Groupes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          Expanded(
            child: bodyGroupes(),
          ),
        ],
      ),
    );
  }
}