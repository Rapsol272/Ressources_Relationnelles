import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/common/loading.dart';

class Friends extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Friends"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('friendship')
            .where('idUser1', isEqualTo: 1)
            .get(),
        builder: ((BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text("Il y a eu une erreur");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          }
          final data = snapshot.requireData;

          return ListView.builder(
            itemCount: data.size,
            itemBuilder: (context, index) {
              DocumentSnapshot snap = (snapshot.data! as dynamic).docs[index];
              return Card(
                child: ListTile(
                  title: Text(
                    snap['idUser1'].toString(),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
