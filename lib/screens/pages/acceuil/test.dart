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
  List<String> l1 = [];
  List<List<String>> l2 = [];
  List<String> tags = <String>[];

  // Récupère depuis Firestore l'ensemble des id des documents de la collection posts dans une liste postId
  getListIdPosts() {
    FirebaseFirestore.instance.collection('posts').get().then(
          (querySnapshot) => {
            querySnapshot.docs.forEach(
              (doc) => {l1.add(doc.id)},
            ),
          },
        );
  }

  Map<String, int> test = {
    'test': 1,
  };
  // Récupère un par un les tags associé au post avec l'Id en paramètre

  // Retourne la liste des éléments contenu dans la liste listTagsById à l'index
  String afficheList(int index) {
    var l3 = l2[index];
    String txt = '';
    for (var i = 0; i < l3.length; i++) {
      txt = txt + l3[i] + ', ';
    }
    return txt;
  }

  // Retourne String avec l'ensemble des données vis-à-vis de tous les
  String afficheIdByTag() {
    String txt = '';
    for (var i = 0; i < l2.length; i++) {
      txt = txt + l1[i] + ' : ' + afficheList(i) + '\n';
    }
    return txt;
  }

// Afficher l'ensemble des id des documents de la collection Posts
  String afficheListPostId() {
    String listeTags = '';
    for (int i = 0; i < l1.length; i++) {
      if (i == tags.length - 1) {
        listeTags = listeTags + l1[i];
      } else {
        listeTags = listeTags + l1[i] + '\n ';
      }
    }
    return listeTags;
  }

  // Complete list l2 with list associated
  initListTagsById() {}

  void initState() {
    super.initState();
    getListIdPosts();
    initListTagsById();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        afficheListPostId() +
            '\n' +
            afficheIdByTag() +
            '\n' +
            l2.toString() +
            ' \n l1 = ' +
            l1.length.toString() +
            ' \n l2 = ' +
            l2.length.toString(),
        style: TextStyle(color: Colors.black, fontSize: 15),
      ),
    );
  }
}
