import 'package:flutter/material.dart';
import 'package:flutter_firebase/common/constants.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/common/constants.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:flutter_firebase/screens/pages/acceuil/commentPage.dart';
import 'package:flutter_firebase/screens/pages/profil/profil.dart';
import 'package:flutter_firebase/services/authentication.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CategSection extends StatefulWidget {
  CategSection({Key? key}) : super(key: key);

  @override
  _CategSectionState createState() => _CategSectionState();
}

class _CategSectionState extends State<CategSection> {
  final List categoSect = [];

  var boxColor = Colors.white;

  // Récupère l'ensemble des catégories dans la collection catégorie
  getCategFirestore() async {
    await FirebaseFirestore.instance.collection('categorie').get().then(
          (querySnapshot) => {
            querySnapshot.docs.forEach(
              (doc) => {categoSect.add(doc.id)},
            ),
          },
        );
  }

  // Construit la barre de sélection des catégories
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getCategFirestore(),
        builder: (context, snapshot) {
          return Container(
            padding: EdgeInsets.all(7),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: greenMajor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(1),
                    spreadRadius: 1.5,
                    blurRadius: 7,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: categoSect.map((element) {
                        var index = categoSect.indexOf(element);
                        return Container(
                          margin: EdgeInsets.only(
                            left: 10,
                            top: 5,
                          ),
                          child: Column(
                            children: [
                              Ink(
                                child: InkWell(
                                  child: Container(
                                    width: 75,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      color: boxColor,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black38,
                                          spreadRadius: 1,
                                          blurRadius: 6,
                                          offset: Offset(
                                            0,
                                            1,
                                          ), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    padding: const EdgeInsets.all(4),
                                    child: IconButton(
                                      onPressed: () {
                                        boxColor = greenMajor;
                                      },
                                      icon: Image.asset('images/pokemon.png'),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Text(
                                  categoSect[index],
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
