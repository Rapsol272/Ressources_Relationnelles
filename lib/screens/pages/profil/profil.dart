import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/common/constants.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:flutter_firebase/screens/pages/bodyAcceuil.dart';
import 'package:flutter_firebase/screens/pages/profil/tab1.dart';
import 'package:flutter_firebase/utils/user_preferences.dart';
import 'package:flutter_firebase/widget/profile_widget.dart';
import 'package:flutter_firebase/screens/pages/accueil.dart';

final usersRef = FirebaseFirestore.instance.collection('users');

class Profil extends StatefulWidget {
  final String? uId;
  const Profil({Key? key, required this.uId}) : super(key: key);

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<Profil> {
  var userData = {};
  int postLen = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uId)
          .get();

      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      userData = userSnap.data()!;
      postLen = postSnap.docs.length;
      setState(() {});
    } catch (e) {
      showSnackBar(BuildContext context, String text) {
        return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(text),
          ),
        );
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : DefaultTabController(
            length: 2,
            child: Scaffold(
              body: Column(
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
                                      //'${data.docs[3]['prenom']} ${data.docs[3]['name']}',
                                      userData['name'].toString(),
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
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    child: TabBarView(children: [bodyAcceuil(), AccountTab1()]),
                  )
                ],
              ),
            ));
  }
}
