import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/common/loading.dart';
import 'package:flutter_firebase/screens/pages/acceuil/storage_service.dart';
import 'package:flutter_firebase/widget/upBar.dart';

class PostsList extends StatefulWidget {
  PostsList({Key? key}) : super(key: key);

  @override
  State<PostsList> createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  Storage storage = new Storage();
  final Stream<QuerySnapshot> posts =
      FirebaseFirestore.instance.collection('posts').snapshots();

  var myUserId = FirebaseAuth.instance.currentUser!.uid;

  List<String> allPosts = [];
  List<Color> allFavPostUser = [];

  getData() async {
    List<String> temp = [];

    await FirebaseFirestore.instance.collection('posts').get().then(
          (querySnapshot) => {
            querySnapshot.docs.forEach(
              (doc) => {allPosts.add(doc.id)},
            )
          },
        );
    await FirebaseFirestore.instance.collection('posts').get().then(
          (querySnapshot) => {
            querySnapshot.docs.forEach(
              (doc) => {temp.add(doc["idLikeUsers"].cast<String>())},
            )
          },
        );

    for (int i = 0; i < temp.length; i++) {
      for (int j = 0; j < temp[i].length; j++) {
        if (myUserId == temp[i][j]) {
          allFavPostUser.add(Colors.red);
        } else {
          allFavPostUser.add(Colors.grey);
        }
      }
    }
    print(allPosts);
    print(allFavPostUser);
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
                                                leading: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                    child: data.docs[index]
                                                                ['reference'] ==
                                                            ""
                                                        ? Image.asset(
                                                            "images/ressources_relationnelles.png",
                                                          )
                                                        : Image.network(
                                                            '${data.docs[index]['reference']}',
                                                          )),

                                                title: Text(
                                                  '${data.docs[index]['title']}',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                subtitle: Text(
                                                  'Posté par : ${data.docs[index]['auteur']}',
                                                  style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.6),
                                                      fontStyle:
                                                          FontStyle.italic),
                                                ),
                                                trailing: IconButton(
                                                    onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              AlertDialog(
                                                                title: Text(
                                                                    'Supprimer ce post ?'),
                                                                content:
                                                                    new Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: <
                                                                      Widget>[
                                                                    Text(
                                                                      "Voulez-vous vraiment supprimer ce post de : " +
                                                                          '${data.docs[index]['auteur']}',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  ],
                                                                ),
                                                                actions: [
                                                                  ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: Text(
                                                                          'Fermer')),
                                                                  ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                       CollectionReference posts =
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'posts');
                                                  posts
                                                      .doc(data.docs[index].id)
                                                      .delete();
                                                                        Navigator.pop(context);
                                                                      },
                                                                      child: Text(
                                                                          'Supprimer'))
                                                                ],
                                                              ));
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
