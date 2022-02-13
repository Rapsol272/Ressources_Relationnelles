import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/common/constants.dart';
import 'package:flutter_firebase/screens/home/home_screen.dart';
import 'package:flutter_firebase/screens/pages/acceuil/commentPage.dart';
import 'package:flutter_firebase/screens/pages/profil/profil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_firebase/screens/pages/messages/bodymessage.dart';



class creationGroupe extends StatefulWidget {
  @override
  _creationGroupe createState() => _creationGroupe();
}

class _creationGroupe extends State<creationGroupe> {
  var taille =0;
  bool isLoading = false;
  late List<dynamic> friendship;
  var _iconColor = Colors.grey;
  var _iconColorShare = Colors.grey;
  var _iconColorAdd = Colors.grey;

   @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      var user = FirebaseAuth.instance.authStateChanges();

      isLoading = true;
    });
    try {
      var friendship2 = await FirebaseFirestore.instance.collection('friendship')
  .where('idUser2', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  .where('validation', isEqualTo: true)
  .get();

      var friendship1 = await FirebaseFirestore.instance.collection('friendship')
  .where('idUser1', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  .where('validation', isEqualTo: true)
  .get();

      friendship = friendship1.docs + friendship2.docs;
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

 /* @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barre verte d'action "Création du nouveau Post"
      
      body: Container(
        padding: EdgeInsets.all(7),
        child: Flexible(
          child: Container(
            height: 1000,
            padding: EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: greenMajor.withOpacity(1),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: 30,
                      bottom: 10,
                      left: 30,
                      right: 30,
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Relations',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          amis(friendship)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}*/
@override
Widget build(BuildContext context) {
  setState(() {});
 return Scaffold(
    appBar: AppBar(
        foregroundColor: Colors.black12,
        backgroundColor: greenMajor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        title: Title(
          color: Colors.white,
          child: Text(
            'Création du nouveau groupe',
            style: TextStyle(color: Colors.white, fontSize: 19),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: friendship.length,
        itemBuilder: (context, index){
          return Container(
            child: Text(
              "test"
            ),
          );
        }
        
        ),
    );
}
}
