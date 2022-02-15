import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/common/constants.dart';
import 'package:flutter_firebase/screens/home/home_screen.dart';
import 'package:flutter_firebase/screens/pages/acceuil/commentPage.dart';
import 'package:flutter_firebase/screens/pages/components/radioButton.dart';
import 'package:flutter_firebase/screens/pages/profil/friends.dart';
import 'package:flutter_firebase/screens/pages/profil/profil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_firebase/screens/pages/messages/bodymessage.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';



class creationGroupe extends StatefulWidget {
  @override
  _creationGroupe createState() => _creationGroupe();
}
var test;
List<String> list= [];

class _creationGroupe extends State<creationGroupe> {
  var taille =0;
  bool isLoading = false;
  final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
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
      body:
      ListView.builder(
        itemCount: friendship.length,
        itemBuilder: (context, index){
          amies(friendship[index]["idUser1"] , friendship[index]["idUser2"]);
          return Container(
            child:
            ListTile(
              onTap: (){
                addonlist(test.id);
              },
              title : Text(test['name']),
              
            ),
          );
        }
      ),
      bottomNavigationBar:  ElevatedButton(
            style: style,
            onPressed: () {},
            child: const Text('Enabled'),)
      
      
    );
}
}

void addonlist(String id) {
  if(list.contains(id)){
list.remove(id);
  }else
  list.add(id);
}

amies(friends1 ,friends2 ) async {
  dynamic friends;
  if(friends1 == FirebaseAuth.instance.currentUser!.uid){
    friends = friends2;
  }
  else
    friends = friends1;
  test = await FirebaseFirestore.instance.collection('users').doc(friends).get();
}
