import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/common/constants.dart';
import 'package:flutter_firebase/common/loading.dart';
import 'package:flutter_firebase/screens/pages/acceuil/categSection.dart';
import 'package:flutter_firebase/screens/pages/acceuil/commentPage.dart';
import 'package:flutter_firebase/screens/pages/groupe/creationGroupe.dart';
import 'package:flutter_firebase/screens/pages/profil/favoriteposts.dart';
import 'package:flutter_firebase/screens/pages/profil/profil.dart';
import 'package:flutter_firebase/widget/upBar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class bodyAcceuil extends StatefulWidget {
  final String? uId;
  const bodyAcceuil({Key? key, required this.uId}) : super(key: key);
  @override
  _bodyAcceuilState createState() => _bodyAcceuilState();
}

// ignore: camel_case_types
class _bodyAcceuilState extends State<bodyAcceuil> {
  final Stream<QuerySnapshot> posts =
      FirebaseFirestore.instance.collection('posts').snapshots();

  var collectionLikes = FirebaseFirestore.instance.collection('likes');

  var myUserId = FirebaseAuth.instance.currentUser!.uid;
  var _iconColorAdd = Colors.grey;

  bool isLiked = false;

  // Utiliser pour la liste des catégories associées à chaque post
  List<String> tabCategorie = [];
  var userData = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Storage storage = new Storage();
    return Scaffold(
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

          // Première Listview builder : création d'une page scrollable
          return ListView.builder(
            itemCount: 1,
            itemBuilder: (context, i) {
              return SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    // Appel du constructeur de la barre des catégories
                    CategSection(),

                    // Seconde Listview builder : création d'une liste de post en correspondance avec la collection post dans firestore
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.size,
                      itemBuilder: (context, index) {
                        tabCategorie = data.docs[index]["tags"].cast<String>();
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
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Column(
                              children: [
                                ListTile(
                                  // IconButton profil disponible sur chaque post : renvoie au profil du rédacteur
                                  leading: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Scaffold(
                                                  appBar: upBar(context,
                                                      'Ressources Relationnelles'),
                                                  body: Profil(
                                                      uId: data.docs[index]
                                                          ['idUser']),
                                                )),
                                      );
                                    },
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(''),
                                    ),
                                  ),
                                  title: Text(
                                    '${data.docs[index]['title']}',
                                    style: TextStyle(
                                        fontSize: 18.5,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    '${data.docs[index]['auteur']}',
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.6),
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),

                                // Affichage de l'image associé au post TODO
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: Image.network(
                                      '${data.docs[index]['reference']}',
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 4.0,
                                    bottom: 4.0,
                                  ),
                                  // Partie déroulante du widget card
                                  child: ExpansionTile(
                                    // Affichage des tags associé au post
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        for (var i = 0;
                                            i < tabCategorie.length;
                                            i++)
                                          unitTags(tabCategorie, i)
                                      ],
                                    ),
                                    // Date de création du post
                                    leading: Text(
                                      '${convertDateTimeDisplay(data.docs[index]['dateCreation'].toDate().toString())}',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                    // Contenu textuel du post
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.center,
                                        padding:
                                            const EdgeInsets.only(bottom: 5),
                                        margin: const EdgeInsets.all(10),
                                        child: Text(
                                            '${data.docs[index]['content']}'),
                                      ),
                                    ],
                                  ),
                                ),
                                // Barre d'action du post (favoris, share, add, comment)
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      // Comment button
                                      IconButton(
                                        padding:
                                            const EdgeInsets.only(bottom: 12),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    commentPage(
                                                  uId: FirebaseAuth.instance
                                                      .currentUser!.uid,
                                                  idPost: data.docs[index].id,
                                                  titlePost: data.docs[index]
                                                      ['title'],
                                                ),
                                              ));
                                        },
                                        icon: Icon(FontAwesomeIcons.comment),
                                        color: Colors.grey,
                                      ),

                                      // Button Add  : a regarder plus tard
                                      IconButton(
                                        padding:
                                            const EdgeInsets.only(bottom: 12),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  creationGroupe(),
                                            ),
                                          );
                                        },
                                        icon: Icon(
                                          FontAwesomeIcons.plusSquare,
                                          color: _iconColorAdd,
                                        ),
                                      ),
                                      // Button Add  : a regarder plus tard
                                      IconButton(
                                        padding:
                                            const EdgeInsets.only(bottom: 12),
                                        onPressed: () {
                                          setState(() {
                                            if (_iconColorAdd == Colors.grey) {
                                              _iconColorAdd = Colors.blue;
                                            } else {
                                              _iconColorAdd = Colors.grey;
                                            }
                                          });
                                        },
                                        icon: Icon(
                                          FontAwesomeIcons.share,
                                          color: _iconColorAdd,
                                        ),
                                      ),
                                      // Button like
                                      IconButton(
                                        padding:
                                            const EdgeInsets.only(bottom: 12),
                                        onPressed: () {
                                          if (isLiked == true) {
                                            var myData = {
                                              'idPost': data.docs[index]
                                                  ['idPost'],
                                              'idUser': currentUserId
                                            };
                                            collectionLikes
                                                .add(myData)
                                                .then((value) => print('Like'))
                                                .catchError((error) => print(
                                                    'Add failed: $error'));
                                            setState(() {
                                              isLiked = false;
                                            });
                                          } else if (isLiked == false) {
                                            FirebaseFirestore.instance
                                                .collection('likes')
                                                .where('idPost',
                                                    isEqualTo: data.docs[index]
                                                        ['idPost'])
                                                .where('idUser',
                                                    isEqualTo: currentUserId)
                                                .get()
                                                .then((value) {
                                              value.docs.forEach((element) {
                                                FirebaseFirestore.instance
                                                    .collection('likes')
                                                    .doc(element.id)
                                                    .delete()
                                                    .then((value) {
                                                  print('Dislike');
                                                });
                                              });
                                            });
                                            setState(() {
                                              isLiked = true;
                                            });
                                          }
                                        },
                                        icon: Icon(Icons.favorite,
                                            color: isLiked
                                                ? Colors.red
                                                : Colors.grey),
                                      )
                                    ]),

                                (userData['modo'] == true)
                                    ? IconButton(
                                        padding:
                                            const EdgeInsets.only(bottom: 12),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                    title: Text(
                                                        'Supprimer ce post ?'),
                                                    content: new Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          "Voulez-vous vraiment supprimer ce post de : " +
                                                              '${data.docs[index]['auteur']}',
                                                          style: TextStyle(
                                                              fontSize: 15),
                                                        ),
                                                      ],
                                                    ),
                                                    actions: [
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                              Text('Fermer')),
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            CollectionReference
                                                                posts =
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'posts');
                                                            posts
                                                                .doc(data
                                                                    .docs[index]
                                                                    .id)
                                                                .delete();
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                              Text('Supprimer'))
                                                    ],
                                                  ));
                                        },
                                        icon: Icon(
                                          Icons.delete_outline,
                                          color: Colors.red,
                                        ))
                                    : Container()
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
