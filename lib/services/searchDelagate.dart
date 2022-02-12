import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase/common/constants.dart';
import 'package:flutter_firebase/common/loading.dart';
import 'package:flutter_firebase/widget/upBar.dart';
import 'package:flutter_firebase/screens/pages/profil/profil.dart';

class CustomSearchDelegate extends SearchDelegate {
  

  CollectionReference _firebaseFirestore =
    FirebaseFirestore.instance.collection('posts');
  
  @override 
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        }, 
        icon: Icon(Icons.clear))
    ];
  }

   @override 
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      }, 
      icon: Icon(Icons.arrow_back_ios));
  }

   @override 
  Widget buildResults(BuildContext context) {
    return StreamBuilder(
      stream: _firebaseFirestore.snapshots().asBroadcastStream(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot) {
          if(!snapshot.hasData) {
            return Loading();
          }
          else{
            if (snapshot.data!.docs.where(
                  (QueryDocumentSnapshot<Object?> elements) => elements['auteur']
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase())).isEmpty){
                      return Center(child: Text('Rien de trouvé :('),);
                    }
          }
            return ListView(
              children: [
                ...snapshot.data!.docs.where(
                  (QueryDocumentSnapshot<Object?> element) => element['auteur']
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase())).map((QueryDocumentSnapshot<Object?> data) {

                        final String auteur = data.get('auteur');
                        final String title = data.get('title');
                        final String content = data.get('content');

                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                            child: GestureDetector(
                              onTap: () {Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Scaffold(
                                                  appBar: upBar(context, 'Ressources Relationnelles'),
                                                  body: Profil(
                                                    uId: data.get('idUser')),
                                                )),
                                          );},
                              child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title: Text(auteur,
                                              style: TextStyle(
                                                color: greenMajor, 
                                                fontWeight: FontWeight.bold,),),
                                          subtitle: Text(
                                            title,
                                            style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            content,
                                            overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              softWrap: true , 
                                            style: TextStyle(color: Colors.black.withOpacity(0.4)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),));
                    })
              ],
            );
      });
  }

   @override 
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder(
      stream: _firebaseFirestore.snapshots().asBroadcastStream(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot) {
          if(!snapshot.hasData) {
            return Loading();
          }
          else{
            if (snapshot.data!.docs.where(
                  (QueryDocumentSnapshot<Object?> element) => element['auteur']
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase())).isEmpty){
                      return Center(child: Text('Reessayer plus tard !'),);
                    }
          }
            return ListView(
              children: [
                ...snapshot.data!.docs.map((QueryDocumentSnapshot<Object?> data) {

                        final String auteur = data.get('auteur');
                        final String title = data.get('title');
                        final String content = data.get('content');
                        final String image = data.get('reference');

                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                            child: GestureDetector(
                              onTap: () {Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Scaffold(
                                                  appBar: upBar(context, 'Ressources Relationnelles'),
                                                  body: Profil(
                                                    uId: FirebaseAuth.instance
                                                        .currentUser!.uid),
                                                )),
                                          );},
                              child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title: Text(auteur,
                                              style: TextStyle(
                                                color: greenMajor, 
                                                fontWeight: FontWeight.bold,),),
                                          subtitle: Text(
                                            title,
                                            style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            content,
                                            overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              softWrap: true , 
                                            style: TextStyle(color: Colors.black.withOpacity(0.4)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),));
                    })
              ],
            );
      });
  }
}

