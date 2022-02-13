import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/common/constants.dart';
import 'package:flutter_firebase/common/loading.dart';
import 'package:flutter_firebase/screens/pages/acceuil/categSection.dart';
import 'package:flutter_firebase/screens/pages/acceuil/commentPage.dart';
import 'package:flutter_firebase/screens/pages/groupe/creationGroupe.dart';
import 'package:flutter_firebase/screens/pages/profil/profil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter_firebase/screens/pages/acceuil/storage_service.dart';

// ignore: camel_case_types

class bodyAcceuil extends StatefulWidget {
  @override
  _bodyAcceuilState createState() => _bodyAcceuilState();
}

// ignore: camel_case_types
class _bodyAcceuilState extends State<bodyAcceuil> {
  final Stream<QuerySnapshot> posts =
      FirebaseFirestore.instance.collection('posts').snapshots();

  var myUserId = FirebaseAuth.instance.currentUser!.uid;
  var _iconColorShare = Colors.grey;
  var _iconColorAdd = Colors.grey;
  var _iconFav = Colors.grey;

  // Utiliser pour la liste des catégories associées à chaque post
  List<String> tabCategorie = [];
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Storage storage = new Storage();
    return FutureBuilder(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                            tabCategorie =
                                data.docs[index]["tags"].cast<String>();
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
                                      leading: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Profil(
                                                    uId: FirebaseAuth.instance
                                                        .currentUser!.uid)),
                                          );
                                        },
                                        child: Icon(
                                          Icons.portrait,
                                          color: Colors.white,
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(),
                                          padding: EdgeInsets.all(10),
                                          primary: Color(0xff03989E),
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
                                            color:
                                                Colors.black.withOpacity(0.6),
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),

                                    // Affichage de l'image associé au post TODO
                                    ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        child:
                                            data.docs[index]['reference'] == ""
                                                ? Image.asset(
                                                    "images/test1.jpg",
                                                  )
                                                : Image.network(
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
                                            padding: const EdgeInsets.only(
                                                bottom: 5),
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
                                                  idPost: data.docs[index].id,
                                                  titlePost: data.docs[index]
                                                      ['title'],
                                                ),
                                              ),
                                            );
                                          },
                                          icon: Icon(FontAwesomeIcons.comment),
                                          color: Colors.grey,
                                        ),
                                        // Button share et/ ou création d'un nouveau groupe
                                        IconButton(
                                          padding:
                                              const EdgeInsets.only(bottom: 12),
                                          onPressed: () {
                                            setState(() {
                                              if (_iconColorShare ==
                                                  Colors.grey) {
                                                _iconColorShare = Colors.green;
                                              } else {
                                                _iconColorShare = Colors.grey;
                                              }
                                            });
                                          },
                                          icon: Icon(
                                            FontAwesomeIcons.retweet,
                                            color: _iconColorShare,
                                          ),
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
                                                    creationGroupe(
                                                  
                                                ),
                                              ),
                                            );
                                          },
                                          icon: Icon(
                                            FontAwesomeIcons.plusSquare,
                                            color: _iconColorAdd,
                                          ),
                                        ),
                                        // Button like
                                        IconButton(
                                          padding:
                                              const EdgeInsets.only(bottom: 12),
                                          onPressed: () {},
                                          icon: Icon(
                                            FontAwesomeIcons.heart,
                                            color: _iconColorAdd,
                                          ),
                                        ),
                                      ],
                                    ),
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
      },
    );
  }
}

String convertDateTimeDisplay(String date) {
  final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
  final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
  final DateTime displayDate = displayFormater.parse(date);
  final String formatted = serverFormater.format(displayDate);
  return formatted;
}

void getUser() {
  StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').doc().snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading");
        }
        var userDocument = snapshot.data;
        return Container();
      });
}

// Create une pillule dans la barre des tags pour un tag i dans la list array
unitTags(List array, int i) {
  return Flexible(
    child: Container(
      margin: const EdgeInsets.only(right: 5, left: 5),
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
          bottomLeft: Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            greenMajor,
            Color(0xffaefea01),
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            array[i],
            style: TextStyle(
              color: Colors.white,
              fontSize: 8,
            ),
          ),
        ],
      ),
    ),
  );
}
