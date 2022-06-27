import 'package:flutter/material.dart';

import 'package:flutter_firebase/screens/pages/groupe/bodyGroupes.dart';


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
