import 'package:flutter/material.dart';
import 'package:flutter_firebase/common/constants.dart';
import 'package:flutter_firebase/screens/pages/acceuil/categSection.dart';
import 'package:flutter_firebase/screens/pages/acceuil/commentPage.dart';
import 'package:flutter_firebase/screens/pages/acceuil/favoriteGroupsAccueil.dart';
import 'package:flutter_firebase/screens/pages/profil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

// ignore: camel_case_types
class bodyAcceuil extends StatefulWidget {
  @override
  _bodyAcceuilState createState() => _bodyAcceuilState();
}

// ignore: camel_case_types
class _bodyAcceuilState extends State<bodyAcceuil> {
  final Stream<QuerySnapshot> posts =
      FirebaseFirestore.instance.collection('posts').snapshots();

  var _iconColorShare = Colors.grey;
  var _iconColorAdd = Colors.grey;
  List<String> array = [];

  // Pour récupérer les ids de tous les documents afin de les parcourir pour récupérer leurs tags (champ tags)
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: posts,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text("Il y a eu une erreur");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('En chargement');
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
                        array = data.docs[index]["tags"].cast<String>();
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
                                            builder: (context) => Profil()),
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
                                        color: Colors.black.withOpacity(0.6),
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),

                                // Affichage de l'image associé au post TODO
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Image.asset(
                                    "images/test1.jpg",
                                  ),
                                ),
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
                                        for (var i = 0; i < array.length; i++)
                                          unitTags(array, i)
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
                                            builder: (context) => commentPage(),
                                          ),
                                        );
                                      },
                                      icon: Icon(FontAwesomeIcons.comment),
                                      color: Colors.grey,
                                    ),
                                    IconButton(
                                      padding:
                                          const EdgeInsets.only(bottom: 12),
                                      onPressed: () {
                                        setState(() {
                                          if (_iconColorShare == Colors.grey) {
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
                                        FontAwesomeIcons.plusSquare,
                                        color: _iconColorAdd,
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          const EdgeInsets.only(bottom: 12),
                                      child: FavoriteButton(
                                        iconSize: 50,
                                        iconColor: Colors.red,
                                        valueChanged: (_isFavorite) {
                                          print('Is Favorite $_isFavorite)');
                                        },
                                      ),
                                    )
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
              fontSize: 12,
            ),
          ),
        ],
      ),
    ),
  );
}
