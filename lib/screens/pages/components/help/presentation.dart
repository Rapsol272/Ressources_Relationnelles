import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/common/loading.dart';
import 'package:flutter_firebase/widget/upBar.dart';

class Presentation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   CollectionReference params = FirebaseFirestore.instance.collection('params');

    return FutureBuilder<DocumentSnapshot>(
      future: params.doc('presentation').get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: upBar(context, 'Ressources Relationnelles'),
            body: SingleChildScrollView(
              child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                children: [
                  Text('Présentation d\'application'),
                  Text("${data['content']}"),
                ],
              )),
            )
          );
        }

        return Loading();
      },
    );
  }
}