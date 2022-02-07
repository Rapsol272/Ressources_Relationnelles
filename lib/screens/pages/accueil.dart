import 'package:flutter/material.dart';
import 'package:flutter_firebase/common/constants.dart';
import 'package:flutter_firebase/screens/pages/acceuil/addPostPage.dart';
import 'package:flutter_firebase/screens/pages/acceuil/bodyAccueil.dart';

class Accueil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: bodyAcceuil(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: or,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPostPage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
