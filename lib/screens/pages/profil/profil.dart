import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/common/constants.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:flutter_firebase/screens/pages/bodyAcceuil.dart';
import 'package:flutter_firebase/screens/pages/profil/edit_profile.dart';
import 'package:flutter_firebase/screens/pages/profil/tab1.dart';
import 'package:flutter_firebase/services/authentication.dart';
import 'package:flutter_firebase/utils/user_preferences.dart';
import 'package:flutter_firebase/widget/profile_widget.dart';
import 'package:flutter_firebase/widget/numbers_widgets.dart';
import 'package:flutter_firebase/screens/pages/accueil.dart';
import 'package:scroll_navigation/scroll_navigation.dart';

class Profil extends StatefulWidget {
  /* final String userId;

  Profil({required this.userId}); */

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<Profil> {
  final Stream<QuerySnapshot> users =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          body: StreamBuilder<QuerySnapshot>(
              stream: users,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Text("Il y a eu une erreur");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('En chargement');
                }
                final data = snapshot.requireData;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // profile picture
                          ProfileWidget(
                              imagePath: user.image, onClicked: () async {}),

                          // number of posts, followers, following
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                        '${data.docs[4]['prenom']} ${data.docs[4]['name']}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                    Text(
                                      'Développeur',
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [Text('')],
                                ),
                                Column(
                                  children: [Text('')],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Name and bio
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        '12 Posts',
                                        style: TextStyle(color: Colors.black54),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        '|',
                                        style: TextStyle(color: Colors.black54),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Accueil()));
                                              },
                                              child: Text(
                                                'Amis',
                                                style: TextStyle(
                                                    color: Colors.black54),
                                              )),
                                          Icon(Icons.person)
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),

                    TabBar(
                      labelColor: Colors.black54,
                      indicatorColor: greenMajor,
                      labelStyle: TextStyle(fontSize: 13),
                      tabs: [
                        new Container(
                          height: 30.0,
                          child: new Tab(
                            text: 'Vos posts',
                          ),
                        ),
                        new Container(
                          height: 30.0,
                          child: new Tab(
                            text: 'Vos favoris',
                          ),
                        )
                      ],
                    ),

                    Expanded(
                      child:
                          TabBarView(children: [bodyAcceuil(), AccountTab1()]),
                    )
                  ],
                );
              }),
        ));
  }
}

Widget buildName(AppUserData user) => Row(
      children: [
        Text(
          user.name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        const SizedBox(height: 24),
        Text(
          user.prenom,
          style: TextStyle(color: Colors.grey),
        )
      ],
    );

Widget buildAbout(AppUserData user) => Container(
      padding: EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'A propos de moi',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            user.about,
            style: TextStyle(fontSize: 16, height: 1.4),
          ),
        ],
      ),
    );
