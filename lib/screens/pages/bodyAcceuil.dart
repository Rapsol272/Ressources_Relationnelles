import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/pages/commentPage.dart';
import 'package:flutter_firebase/screens/pages/profil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter_firebase/screens/pages/postHelper.dart';
import 'package:flutter_firebase/screens/pages/postItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/common/constants.dart';

class bodyAcceuil extends StatefulWidget {
  @override
  _bodyAcceuilState createState() => _bodyAcceuilState();
}

class _bodyAcceuilState extends State<bodyAcceuil> {
  final Stream<QuerySnapshot> posts =
      FirebaseFirestore.instance.collection('posts').snapshots();
  var _iconColor = Colors.grey;
  var _iconColorShare = Colors.grey;
  var _iconColorAdd = Colors.grey;

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
          return ListView.builder(
            itemCount: data.size,
            itemBuilder: (context, index) {
              return SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        PostItemModel posts = PostHelper.getPost(index);
                        return Container(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 5,
                            bottom: 5,
                          ),
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
                                      primary:
                                          Color(0xff03989E), // <-- Button color
                                      onPrimary: Colors.red, // <-- Splash color
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
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Image.asset(
                                    posts.image,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 4.0, bottom: 4.0),
                                  child: ExpansionTile(
                                    title: Text(
                                      posts.toString(),
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xff03989E),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    leading: Text(
                                      '${data.docs[index]['dateCreation']}',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    IconButton(
                                      padding:
                                          const EdgeInsets.only(bottom: 12),
                                      onPressed: () {
                                        commentPage();
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
