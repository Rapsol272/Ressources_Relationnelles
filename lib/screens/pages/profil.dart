import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:flutter_firebase/screens/pages/bodyAcceuil.dart';
import 'package:flutter_firebase/screens/pages/edit_profile.dart';
import 'package:flutter_firebase/services/authentication.dart';
import 'package:flutter_firebase/utils/user_preferences.dart';
import 'package:flutter_firebase/widget/profile_widget.dart';
import 'package:flutter_firebase/widget/numbers_widgets.dart';
import 'package:flutter_firebase/screens/pages/accueil.dart';

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

    return Scaffold(
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

            return ListView(
              physics: BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 24),
                //buildName(user),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              color: Colors.grey[300], shape: BoxShape.circle),
                        ),
                        Column(
                          children: [
                            Text(
                              '${data.docs[4]['prenom']} ${data.docs[4]['name']}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Wrap(
                                  spacing: 20,
                                  runSpacing: 20,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          'Développeur',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Wrap(
                                  spacing: 20,
                                  runSpacing: 20,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          ('Posts'),
                                          style: TextStyle(),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [Text('Amis')],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),

                /* Text(
                  '${data.docs[3]['name']}',
                  //'dqfzafa',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ), */
                /* const SizedBox(height: 24),
                NumbersWidget(),
                const SizedBox(height: 48),
                buildAbout(user) */
              ],
            );
          }),
    );
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
