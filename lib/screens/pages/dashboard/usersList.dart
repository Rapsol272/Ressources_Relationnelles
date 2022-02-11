import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/common/constants.dart';
import 'package:flutter_firebase/common/loading.dart';
import 'package:flutter_firebase/screens/pages/acceuil/categSection.dart';
import 'package:flutter_firebase/screens/pages/acceuil/commentPage.dart';
import 'package:flutter_firebase/screens/pages/profil/profil.dart';
import 'package:flutter_firebase/widget/upBar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter_firebase/screens/pages/acceuil/storage_service.dart';

// ignore: camel_case_types

class UsersList extends StatefulWidget {
  @override
  _UsersListState createState() => _UsersListState();
}

// ignore: camel_case_types
class _UsersListState extends State<UsersList> {
  final Stream<QuerySnapshot> posts =
      FirebaseFirestore.instance.collection('users').snapshots();

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
    await FirebaseFirestore.instance.collection('users').get().then(
          (querySnapshot) => {
            querySnapshot.docs.forEach(
              (doc) => {allPosts.add(doc.id)},
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

              // Première Listview builder : création d'une page scrollable
              return ListView.builder(
                itemCount: 1,
                itemBuilder: (context, i) {
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

                                      title: Text(
                                        '${data.docs[index]['title']}',
                                        style: TextStyle(
                                            fontSize: 18.5,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                        'tet',
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.6),
                                            fontStyle: FontStyle.italic),
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
                                        title: Text('Test')
                                      ),
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
