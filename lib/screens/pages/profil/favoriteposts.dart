// ignore_for_file: unnecessary_null_comparison
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/common/constants.dart';
import 'package:flutter_firebase/common/loading.dart';

var posts = FirebaseFirestore.instance
    .collection('posts')
    .where('idUser', isEqualTo: currentUserId);
final String currentUserId = FirebaseAuth.instance.currentUser!.uid;

class FavoritePosts extends StatefulWidget {
  final String? uId;
  const FavoritePosts({Key? key, required this.uId}) : super(key: key);

  @override
  _FavoritePosts createState() => _FavoritePosts();
}

class _FavoritePosts extends State<FavoritePosts> {
  var userData = {};
  int postLen = 0;
  bool isLoading = false;
  List<String> array = [];
  var userId = FirebaseFirestore.instance.collection('users');
  var collectionLikes = FirebaseFirestore.instance.collection('likes');

  //Map likes = [] as Map;
  bool isLiked = false;

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

  @override
  Widget build(BuildContext context) {
    //final user = UserPreferences.myUser;
    //isLiked = (likes[currentUserId] == true);
    return isLoading
        ? Loading()
        : FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('posts')
                .where('idUser', isEqualTo: widget.uId)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView.builder(
                itemCount: postLen,
                itemBuilder: (context, index) {
                  DocumentSnapshot snap =
                      (snapshot.data! as dynamic).docs[index];
                  return (collectionLikes
                              .where('idPost', isEqualTo: snap.id)
                              .toString() ==
                          snap.id.toString())
                      ? SingleChildScrollView(
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
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        leading: ElevatedButton(
                                          onPressed: () {},
                                          child: Icon(
                                            Icons.portrait,
                                            color: Colors.white,
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            shape: CircleBorder(),
                                            padding: EdgeInsets.all(10),
                                            primary: Color(
                                                0xff03989E), // <-- Button color
                                            onPrimary:
                                                Colors.red, // <-- Splash color
                                          ),
                                        ),
                                        title: Text(
                                          //'${data.docs[index]['title']}',
                                          snap['title'].toString(),
                                          style: TextStyle(
                                              fontSize: 18.5,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                          //'${data.docs[index]['auteur']}',
                                          userData['name'].toString() +
                                              userData['prenom'].toString(),
                                          style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        child: snap['reference'] == ""
                                            ? Image.asset(
                                                "images/test1.jpg",
                                              )
                                            : Image.network(
                                                '${snap['reference']}',
                                              ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 4.0, bottom: 4.0),
                                        child: ExpansionTile(
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              for (var i = 0;
                                                  i < array.length;
                                                  i++)
                                                unitTags(array, i)
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
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.only(
                                                  bottom: 5),
                                              margin: const EdgeInsets.all(10),
                                              child: Text(
                                                  //'${data.docs[index]['content']}'),
                                                  snap['content'].toString()),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      : Container();
                },
              );
            },
          );
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
