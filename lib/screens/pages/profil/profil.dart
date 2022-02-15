import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/common/constants.dart';
import 'package:flutter_firebase/common/loading.dart';
import 'package:flutter_firebase/screens/authenticate/scrollAuth.dart';
import 'package:flutter_firebase/screens/pages/acceuil/commentPage.dart';
import 'package:flutter_firebase/screens/pages/profil/favoriteposts.dart';
import 'package:flutter_firebase/screens/pages/profil/friends.dart';
import 'package:flutter_firebase/services/authentication.dart';
import 'package:flutter_firebase/widget/follow_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

final usersRef = FirebaseFirestore.instance.collection('users');

class Profil extends StatefulWidget {
  final String? uId;
  const Profil({
    Key? key,
    required this.uId,
  }) : super(key: key);

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<Profil> {
  var userData = {};
  int postLen = 0;
  bool isLoading = false;
  var _iconColor = Colors.grey;
  var _iconColorShare = Colors.grey;
  var _iconColorAdd = Colors.grey;
  bool isLiked = false;
  List<String> array = [];
  var collectionLikes = FirebaseFirestore.instance.collection('likes');

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uId)
          .get();

      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('idUser', isEqualTo: widget.uId)
          .get();

      userData = userSnap.data()!;
      postLen = postSnap.docs.length;
      setState(() {});
    } catch (e) {
      showSnackBar(BuildContext context, String text) {
        return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(text),
          ),
        );
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  final AuthenticationService _auth = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    var hasWidthPage = MediaQuery.of(context).size.width;
    setState(() {});
    return isLoading
        ? Loading()
        : DefaultTabController(
            length: 2,
            child: Scaffold(
              body: (userData['name'] == null)
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10, horizontal: hasWidthPage * 0.15),
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Align(
                                alignment: Alignment(-0.8, -0.2),
                                widthFactor: hasWidthPage * 0.02,
                                heightFactor: hasWidthPage * 0.0019,
                                child: Image.asset(
                                    'images/ressources_relationnelles.png'),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  onPressed: () async {
                                    await _auth.signOut();
                                  },
                                  child: Text('S\'inscrire')),
                              ElevatedButton(
                                  onPressed: () async {
                                    await _auth.signOut();
                                  },
                                  child: Text('Se connecter'))
                            ],
                          ),
                        ],
                      )),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                        radius: hasWidthPage * 0.09,
                                        backgroundImage: NetworkImage(
                                          userData['reference'].toString(),
                                        )),
                                    SizedBox(
                                      width: hasWidthPage * 0.1,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                            userData['prenom'].toString() +
                                                ' ' +
                                                userData['name'].toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                        Text(
                                          userData['bio'].toString(),
                                          style:
                                              TextStyle(color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Name and bio
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      buildStatColumn(postLen, "posts"),
                                      Column(
                                        children: [
                                          Text(
                                            '|',
                                            style: TextStyle(
                                                color: Colors.black54),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    Friends()));
                                                  },
                                                  child:
                                                      currentUserId ==
                                                              widget.uId
                                                          ? Text(
                                                              'Amis',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black54),
                                                            )
                                                          : FollowButton(
                                                              backgroundColor:
                                                                  greenMajor,
                                                              borderColor:
                                                                  Colors.grey,
                                                              text: 'Suivre',
                                                              textColor:
                                                                  Colors.white,
                                                              function: () {
                                                                var myData = {
                                                                  'idUser1':
                                                                      currentUserId,
                                                                  'idUser2':
                                                                      widget
                                                                          .uId,
                                                                  'validation':
                                                                      true,
                                                                };
                                                                var collection =
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'friendship');
                                                                collection
                                                                    .add(
                                                                        myData) // <-- Your data
                                                                    .then((_) =>
                                                                        print(
                                                                            'Added'))
                                                                    .catchError(
                                                                        (error) =>
                                                                            print('Add failed: $error'));
                                                              },
                                                            )),
                                              Icon(Icons.person)
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  )),
                            ],
                          ),
                        ),

                        TabBar(
                          labelColor: Colors.black54,
                          indicatorColor: greenMajor,
                          labelStyle: TextStyle(fontSize: 13),
                          tabs: [
                            new Container(
                              height: 30.0,
                              child: new Tab(
                                text: 'Vos posts',
                              ),
                            ),
                            new Container(
                              height: 30.0,
                              child: new Tab(
                                text: 'Vos favoris',
                              ),
                            )
                          ],
                        ),

                        Expanded(
                          child: TabBarView(children: [
                            FutureBuilder(
                              future: FirebaseFirestore.instance
                                  .collection('posts')
                                  .where('idUser', isEqualTo: widget.uId)
                                  .get(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                final data = snapshot.requireData;
                                return ListView.builder(
                                  itemCount: postLen,
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot snap =
                                        (snapshot.data! as dynamic).docs[index];

                                    return SingleChildScrollView(
                                      physics: ScrollPhysics(),
                                      child: Column(
                                        children: <Widget>[
                                          Container(
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
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
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
                                                              builder: (context) => Profil(
                                                                  uId: FirebaseAuth
                                                                      .instance
                                                                      .currentUser!
                                                                      .uid)),
                                                        );
                                                      },
                                                      child: Icon(
                                                        Icons.portrait,
                                                        color: Colors.white,
                                                      ),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        shape: CircleBorder(),
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        primary: Color(
                                                            0xff03989E), // <-- Button color
                                                        onPrimary: Colors
                                                            .red, // <-- Splash color
                                                      ),
                                                    ),
                                                    title: Text(
                                                      //'${data.docs[index]['title']}',
                                                      snap['title'].toString(),
                                                      style: TextStyle(
                                                          fontSize: 18.5,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    subtitle: Text(
                                                      //'${data.docs[index]['auteur']}',
                                                      userData['prenom']
                                                              .toString() +
                                                          ' ' +
                                                          userData['name']
                                                              .toString(),
                                                      style: TextStyle(
                                                          color: Colors.black
                                                              .withOpacity(0.6),
                                                          fontStyle:
                                                              FontStyle.italic),
                                                    ),
                                                  ),
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                    child:
                                                        snap['reference'] == ""
                                                            ? Image.asset(
                                                                "images/test1.jpg",
                                                              )
                                                            : Image.network(
                                                                '${snap['reference']}',
                                                              ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 4.0,
                                                            bottom: 4.0),
                                                    child: ExpansionTile(
                                                      title: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          for (var i = 0;
                                                              i < array.length;
                                                              i++)
                                                            unitTagsmdr(
                                                                array, i)
                                                        ],
                                                      ),
                                                      leading: Text(
                                                        //'${data.docs[index]['dateCreation']}',
                                                        '${convertDateTimeDisplay(snap['dateCreation'].toDate().toString())}',

                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      children: <Widget>[
                                                        Container(
                                                          alignment:
                                                              Alignment.center,
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 5),
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          child: Text(
                                                              //'${data.docs[index]['content']}'),
                                                              snap['content']
                                                                  .toString()),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: <Widget>[
                                                      IconButton(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 12),
                                                        onPressed: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      commentPage(
                                                                uId: FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .uid,
                                                                idPost: snap.id,
                                                                titlePost: snap[
                                                                    'title'],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        icon: Icon(
                                                            FontAwesomeIcons
                                                                .comment),
                                                        color: Colors.grey,
                                                      ),
                                                      IconButton(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 12),
                                                        onPressed: () {
                                                          setState(() {
                                                            if (_iconColorShare ==
                                                                Colors.grey) {
                                                              _iconColorShare =
                                                                  Colors.green;
                                                            } else {
                                                              _iconColorShare =
                                                                  Colors.grey;
                                                            }
                                                          });
                                                        },
                                                        icon: Icon(
                                                          FontAwesomeIcons
                                                              .retweet,
                                                          color:
                                                              _iconColorShare,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 12),
                                                        onPressed: () {
                                                          setState(() {
                                                            if (_iconColorAdd ==
                                                                Colors.grey) {
                                                              _iconColorAdd =
                                                                  Colors.blue;
                                                            } else {
                                                              _iconColorAdd =
                                                                  Colors.grey;
                                                            }
                                                          });
                                                        },
                                                        icon: Icon(
                                                          FontAwesomeIcons
                                                              .plusSquare,
                                                          color: _iconColorAdd,
                                                        ),
                                                      ),
                                                      Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 12),
                                                          child: IconButton(
                                                            onPressed: () {
                                                              if (isLiked ==
                                                                  true) {
                                                                isLiked = false;
                                                                var myData = {
                                                                  'idPost':
                                                                      snap.id,
                                                                  'idUser':
                                                                      currentUserId
                                                                };
                                                                collectionLikes
                                                                    .add(myData)
                                                                    .then((value) =>
                                                                        print(
                                                                            'Like'))
                                                                    .catchError(
                                                                        (error) =>
                                                                            print('Add failed: $error'));
                                                                setState(() {});
                                                              } else if (isLiked ==
                                                                  false) {
                                                                isLiked = true;
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'likes')
                                                                    .where(
                                                                        'idPost',
                                                                        isEqualTo:
                                                                            snap
                                                                                .id)
                                                                    .where(
                                                                        'idUser',
                                                                        isEqualTo:
                                                                            currentUserId)
                                                                    .get()
                                                                    .then(
                                                                        (value) {
                                                                  value.docs
                                                                      .forEach(
                                                                          (element) {
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'likes')
                                                                        .doc(element
                                                                            .id)
                                                                        .delete()
                                                                        .then(
                                                                            (value) {
                                                                      print(
                                                                          'Dislike');
                                                                    });
                                                                  });
                                                                });
                                                                setState(() {});
                                                              }
                                                            },
                                                            icon: Icon(
                                                                Icons.favorite,
                                                                color: isLiked
                                                                    ? Colors.red
                                                                    : Colors
                                                                        .grey),
                                                          ))
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            FavoritePosts(
                              uId: currentUserId,
                            )
                          ]),
                        )
                      ],
                    ),
            ));
  }

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  Column buildStatColumn(int num, String label) {
    return Column(
      children: [
        Text(
          num.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          child: Text(
            label,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w400, color: Colors.grey),
          ),
        )
      ],
    );
  }
}

unitTagsmdr(List array, int i) {
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
