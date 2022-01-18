import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/home/home_screen.dart';
import 'package:flutter_firebase/screens/pages/profil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter_firebase/screens/pages/postHelper.dart';
import 'package:flutter_firebase/screens/pages/postItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/common/constants.dart';
import 'package:flutter_firebase/common/constants.dart';

import 'components/help.dart';
import 'components/params.dart';

class commentPage extends StatefulWidget {
  commentPage({Key? key}) : super(key: key);

  @override
  _commentPageState createState() => _commentPageState();
}

class _commentPageState extends State<commentPage> {
  final AuthenticationService _auth = AuthenticationService();
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
            'Titre du post',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onSelected: (choice) {
              switch (choice) {
                case 0:
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Params()));
                  break;
                case 1:
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Help()));
                  break;
                // other cases...
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                  value: 0,
                  child: Row(children: <Widget>[
                    Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                        child: Icon(
                          Icons.settings,
                          color: greenMajor,
                        )),
                    Text('Paramètres')
                  ])),
              PopupMenuItem(
                  value: 1,
                  child: Row(children: <Widget>[
                    Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                        child: Icon(
                          Icons.help,
                          color: greenMajor,
                        )),
                    Text('Aide')
                  ])),
              PopupMenuItem(
                  onTap: () async {},
                  child: Row(children: <Widget>[
                    Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                        child: Icon(
                          Icons.edit,
                          color: greenMajor,
                        )),
                    Text('Modifier mon profil')
                  ])),
              PopupMenuItem(
                  onTap: () async {
                    await _auth.signOut();
                  },
                  child: Row(children: <Widget>[
                    Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                        child: Icon(
                          Icons.logout,
                          color: greenMajor,
                        )),
                    Text('Se déconnecter')
                  ]))
            ],
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 40,
                      itemBuilder: (BuildContext context, int index) {
                        return Flexible(
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.only(
                                top: 10, left: 10, right: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                topLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: greenMajor,
                                  spreadRadius: 0.2,
                                  blurRadius: 3,
                                  offset: Offset(
                                      0, 0.5), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black38,
                                            spreadRadius: 1,
                                            blurRadius: 6,
                                            offset: Offset(0,
                                                1), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      margin: const EdgeInsets.only(right: 5),
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: Image.asset('images/pokemon.png'),
                                      ),
                                    ),
                                  ],
                                ),
                                Flexible(
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          'Lets gooo, je suis un texte de taille variable. Développer par Loïc Salaï le boss. Je ne sais pas si le text va sadapter vis-a-vis de la taille du texte. Je continue mon texte au max  ',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                right: 10,
                                              ),
                                              color: Colors.white,
                                              height: 40,
                                              width: 275,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      shape: BoxShape.rectangle,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black38,
                                                          spreadRadius: 1,
                                                          blurRadius: 2,
                                                          offset: Offset(0,
                                                              1), // changes position of shadow
                                                        ),
                                                      ],
                                                    ),
                                                    child: FavoriteButton(
                                                      iconSize: 20,
                                                      iconColor: Colors.red,
                                                      valueChanged:
                                                          (_isFavorite) {
                                                        print(
                                                            'Is Favorite $_isFavorite)');
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
