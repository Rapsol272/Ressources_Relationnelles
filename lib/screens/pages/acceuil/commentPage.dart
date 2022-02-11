import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/services/authentication.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter_firebase/common/constants.dart';
import 'package:flutter_firebase/common/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/widget/upBar.dart';

// ignore: camel_case_types
class commentPage extends StatefulWidget {
  final String idPost;
  final String titlePost;

  commentPage({Key? key, required this.idPost, required this.titlePost})
      : super(key: key);

  @override
  _commentPageState createState() => _commentPageState();
}

// ignore: camel_case_types
class _commentPageState extends State<commentPage> {
  final AuthenticationService _auth = AuthenticationService();
  final Stream<QuerySnapshot> comments =
      FirebaseFirestore.instance.collection('comments').snapshots();
  var myControllerTitle = TextEditingController();
  var myUserId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: upBar(context, widget.titlePost,),
      bottomNavigationBar: Container(
        width: 300,
        height: 85,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(5),
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
              color: Colors.black.withOpacity(1),
              spreadRadius: 0.5,
              blurRadius: 5,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Flexible(
              child: SizedBox(
                child: txtEditingCont('test', 1),
              ),
            ),
            IconButton(
                onPressed: () {
                  var myData = {
                    'idUser': myUserId,
                    'idPost': widget.idPost,
                    'content': myControllerTitle.text,
                    'dateCreation': DateTime.now(),
                  };
                  var collection =
                      FirebaseFirestore.instance.collection('comments');
                  collection
                      .add(myData) // <-- Your data
                      .then((_) => print('Added'))
                      .catchError((error) => print('Add failed: $error'));
                  setState(() {});
                },
                icon: Icon(
                  Icons.send_sharp,
                  color: greenMajor,
                ))
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: comments,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text("Il y a eu une erreur");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          }
          final data = snapshot.requireData;

          // Première Listview builder : création d'une page scrollable
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
                      if (widget.idPost == data.docs[index]['idPost']) {
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
                                          '${data.docs[index]['content']}',
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
                                                      iconSize: 40,
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
                      } else {
                        return Container();
                      }
                    }),
              ],
            ),
          );
        },
      ),
    );
  }

  txtEditingCont(String label, int max) {
    return Column(
      children: [
        const SizedBox(height: 1),
        TextField(
          controller: myControllerTitle,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          maxLines: max,
        ),
      ],
    );
  }
}
