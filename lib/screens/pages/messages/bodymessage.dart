import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/common/constants.dart';
import 'package:flutter_firebase/common/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: camel_case_types
class Messages extends StatefulWidget {
  final String idGroupe;
  final String nameGroupe;
  Color _colorContainer1 = greenMajor;
  Color _colorContainer2 = Color(0xffaefea01);

  Messages({Key? key, required this.idGroupe, required this.nameGroupe})
      : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}

// ignore: camel_case_types
class _MessagesState extends State<Messages> {
  var myControllerTitle = TextEditingController();
  var myUserId = FirebaseAuth.instance.currentUser!.uid;

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
            widget.nameGroupe,
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
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
                    'content': myControllerTitle.text,
                    'dateCreation': DateTime.now(),
                  };
                  var collection =
                      FirebaseFirestore.instance.collection('groupes').doc(widget.idGroupe).collection('messages');
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
        stream: FirebaseFirestore.instance.collection('groupes').doc(widget.idGroupe).collection('messages').snapshots(),
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
                      if(data.docs[index]['idUser'] == myUserId){
                        return Container(
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
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 5,
                    bottom: 5,
                  ),
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 5,
                    bottom: 5,
                  ),
                  child :
                  
                  Text(
                        '${data.docs[index]['content']}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.end,
                      )
                      );
                      }else{
                        return Container(
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
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 5,
                    bottom: 5,
                  ),
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 5,
                    bottom: 5,
                  ),
                  child :
                  
                  Text(
                        '${data.docs[index]['content']}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.start,
                      )
                      );
                      }
                      
                    }
                    ),
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

  
