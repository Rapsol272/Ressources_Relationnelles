import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/common/loading.dart';
import 'package:flutter_firebase/screens/pages/acceuil/storage_service.dart';
import 'package:flutter_firebase/widget/upBar.dart';

class CommentsList extends StatefulWidget {
  CommentsList({Key? key}) : super(key: key);

  @override
  State<CommentsList> createState() => _CommentsListState();
}

class _CommentsListState extends State<CommentsList> {
  Storage storage = new Storage();
  final Stream<QuerySnapshot> posts =
      FirebaseFirestore.instance.collection('comments').snapshots();

  var myUserId = FirebaseAuth.instance.currentUser!.uid;

  List<String> allComments = [];

  getData() async {
    List<String> temp = [];

    await FirebaseFirestore.instance.collection('comments').get().then(
          (querySnapshot) => {
            querySnapshot.docs.forEach(
              (doc) => {allComments.add(doc.id)},
            )
          },
        );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Scaffold(
            appBar: upBar(context, 'Ressources Relationnelles'),
            body: StreamBuilder<QuerySnapshot>(
                stream: posts,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Text("Il y a eu une erreur");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Loading();
                  }
                  final data = snapshot.requireData;
                  return ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, i) {
                        return SingleChildScrollView(
                            physics: ScrollPhysics(),
                            child: Column(children: <Widget>[
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: data.size,
                                  itemBuilder: (context, index) {
                                    return Container(
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 5,
                                          bottom: 5,
                                        ),
                                        // Création de la card avec l'ensemble du contenu
                                        child: Card(
                                            elevation: 15,
                                            margin: EdgeInsets.all(5),
                                            shadowColor: Color(0xff03989E),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            clipBehavior: Clip.antiAlias,
                                            child: Column(children: [
                                              ListTile(
                                                // IconButton profil disponible sur chaque post : renvoie au profil du rédacteur

                                                title: Text(
                                                  '${data.docs[index]['content']}',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                trailing: IconButton(
                                                    onPressed: () {
                                                      
                                                    },
                                                    icon: Icon(Icons.delete_outline, color: Colors.red,)),
                                              ),
                                            ])));
                                  })
                            ]));
                      });
                }),
          );
        });
  }
}
