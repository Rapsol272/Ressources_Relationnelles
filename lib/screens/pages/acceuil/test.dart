import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/common/constants.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:flutter_firebase/screens/pages/acceuil/commentPage.dart';
import 'package:flutter_firebase/screens/pages/acceuil/favoriteGroupsAccueil.dart';
import 'package:flutter_firebase/screens/pages/profil.dart';
import 'package:flutter_firebase/services/authentication.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Test extends StatefulWidget {
  Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  List<String> favIdPostUser = [];
  Map<String, bool> allPostsWFav = {};
  var _iconFav = Colors.grey;

  // Initalise tout
  initAll(String idUser) async {
    // Initalise la map allPostsWFav sans les fav du user
    await FirebaseFirestore.instance.collection('posts').get().then(
          (querySnapshot) => {
            querySnapshot.docs.forEach(
              (doc) => {allPostsWFav[doc.id] = false},
            ),
          },
        );
    // Initialise la liste des post like par l'utilisateur courant
    await FirebaseFirestore.instance.collection('like').get().then(
          (querySnapshot) => {
            querySnapshot.docs.forEach(
              (doc) => {
                doc.data()['idUser'] == idUser
                    ? favIdPostUser.add(doc.data()['idPost'])
                    : null
              },
            ),
          },
        );
    // Value == true signifie que le post a été like par l'utilisateur
    for (var i = 0; i < favIdPostUser.length; i++) {
      for (var j = 0; j < allPostsWFav.length; j++) {
        if (favIdPostUser[i] == allPostsWFav.keys.elementAt(j))
          allPostsWFav.update(
              allPostsWFav.keys.elementAt(j), (value) => value = true);
      }
    }
  }

  // Verif if idPost is liked
  verifIdPost(String idPost) {
    for (var i = 0; i < favIdPostUser.length; i++) {
      if (favIdPostUser[i] == idPost)
        return true;
      else
        return false;
    }
  }

  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initAll('gwyc9IUyPsheUpUDa3Lq3jCEZrJ2'),
      builder: (context, snapshot) {
        return Container(
          child: Column(
            children: [
              Text(
                favIdPostUser.toString() + allPostsWFav.toString(),
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
              IconButton(
                padding: const EdgeInsets.only(bottom: 12),
                onPressed: () {},
                icon: Icon(
                  FontAwesomeIcons.heart,
                  color: verifIdPost('I4Ej3bZxF4cpNtwPOECe')
                      ? Colors.red
                      : Colors.grey,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
