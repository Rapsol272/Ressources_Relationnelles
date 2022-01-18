import 'package:flutter/material.dart';

import 'package:flutter_firebase/screens/pages/bodyAccueil.dart';
import 'package:flutter_firebase/screens/pages/favoriteGroupsAccueil.dart';

class Accueil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: FavoriteSection(),
          ),
          Expanded(
            child: bodyAcceuil(),
          ),
        ],
      ),
    );
  }
}
