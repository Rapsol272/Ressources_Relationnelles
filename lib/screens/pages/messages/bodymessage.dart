import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/common/constants.dart';
import 'package:flutter_firebase/common/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: camel_case_types
class Messages extends StatefulWidget {
  final String idGroupe;
  final String nameGroupe;

  Messages({Key? key, required this.idGroupe, required this.nameGroupe})
      : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}

// ignore: camel_case_types
class _MessagesState extends State<Messages> {
  var myUserId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
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
            widget.nameGroupe,
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('groupes').doc(widget.idGroupe).collection('messages').snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text("Il y a eu une erreur");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          }
          final data = snapshot.requireData;

          // Première Listview builder : création d'une page scrollable
          return SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: <Widget>[
                // Seconde Listview builder : création d'une liste de post en correspondance avec la collection post dans firestore
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.size,
                    itemBuilder: (context, index) {
                      return Text(
                        '${data.docs[index]['content']}'
                      );
                    }),
              ],
            ),
          );
        },
      ),
    );
  }}