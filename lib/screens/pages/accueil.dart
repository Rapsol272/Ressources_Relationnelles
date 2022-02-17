import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/common/constants.dart';
import 'package:flutter_firebase/screens/pages/acceuil/addPostPage.dart';
import 'package:flutter_firebase/screens/pages/acceuil/bodyAccueil.dart';

class Accueil extends StatefulWidget {
  final String? uId;
  Accueil({Key? key, required this.uId}) : super(key: key);

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  var userData = {};
  int postLen = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Expanded(
              child: bodyAcceuil(uId: FirebaseAuth.instance.currentUser!.uid),
            ),
          ],
        ),
        floatingActionButton: (userData['role'].toString() == 'Rédacteur')
            ? FloatingActionButton(
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
              )
            : Container());
  }
}
