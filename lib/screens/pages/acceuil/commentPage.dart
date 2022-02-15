import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/pages/profil/profil.dart';
import 'package:flutter_firebase/services/authentication.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter_firebase/common/constants.dart';
import 'package:flutter_firebase/common/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/widget/upBar.dart';
import 'package:intl/intl.dart';

// ignore: camel_case_types
class commentPage extends StatefulWidget {
  final usersRef = FirebaseFirestore.instance.collection('users');
  final String idPost;
  final String titlePost;
  final String? uId;

  commentPage(
      {Key? key,
      required this.idPost,
      required this.titlePost,
      required this.uId})
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
  var userData = {};

  

  getDataUser() async {
    setState(() {
      var user = FirebaseAuth.instance.authStateChanges();
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uId)
          .get();

      userData = userSnap.data()!;
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
  }

  @override
  void initState() {
    super.initState();
    getDataUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: upBar(
        context,
        widget.titlePost,
      ),
      body:
      Column(
        children: [
      StreamBuilder<QuerySnapshot>(
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                   GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Scaffold(
                                                      appBar: upBar(context,
                                                          'Ressources Relationnelles'),
                                                      body: Profil(
                                                          uId: myUserId),
                                                    )),
                                          );
                                        },
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              userData['reference']),
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
                                        SizedBox(height: 20,),
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
                                                    MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Text(
                                          '${convertDateTimeDisplay(data.docs[index]['dateCreation'].toDate().toString())}',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                        ),
                                                  FavoriteButton(
                                                      iconSize: 40,
                                                      iconColor: Colors.red,
                                                      valueChanged:
                                                          (_isFavorite) {
                                                        print(
                                                            'Is Favorite $_isFavorite)');
                                                      },
                                                    ),
                                                  (userData['modo'] == true)
                                                      ? IconButton(
                                                          onPressed: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    AlertDialog(
                                                                      title: Text(
                                                                          'Supprimer ce post ?'),
                                                                      content:
                                                                          new Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: <
                                                                            Widget>[
                                                                          Text(
                                                                            "Voulez-vous vraiment supprimer ce commentaire ?",
                                                                            style:
                                                                                TextStyle(fontSize: 15),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      actions: [
                                                                        ElevatedButton(
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                Text('Fermer')),
                                                                        ElevatedButton(
                                                                            onPressed:
                                                                                () {
                                                                              CollectionReference posts = FirebaseFirestore.instance.collection('comments');
                                                                              posts.doc(data.docs[index].id).delete();
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                Text('Supprimer'))
                                                                      ],
                                                                    ));
                                                          },
                                                          icon: Icon(
                                                            Icons
                                                                .delete_outline,
                                                            color: Colors.red,
                                                          ))
                                                      : Container(),
                                                      
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
                    Container(
        width: double.infinity,
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
                  myControllerTitle.clear();
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
              ],
            ),
          );
        },
      ),
      ],
      )
    );
  }

  txtEditingCont(String label, int max) {
    return Column(
      children: [
        const SizedBox(height: 1),
        TextField(
          controller: myControllerTitle,
          decoration: InputDecoration(
            label: Text('Entrez votre commentaire...'),
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

String convertDateTimeDisplay(String date) {
  final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
  final DateFormat serverFormater = DateFormat('yyyy-MM-dd HH-mm-ss');
  final DateTime displayDate = displayFormater.parse(date);
  final String formatted = serverFormater.format(displayDate);
  return formatted;
}
