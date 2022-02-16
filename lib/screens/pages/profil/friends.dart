import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/common/constants.dart';

class Friends extends StatefulWidget {
  @override
  _Friends createState() => _Friends();
}

List<dynamic> users_friends = [];

class _Friends extends State<Friends> {
  var taille = 0;
  bool isLoading = false;
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
  late List<String> friendship = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    try {
      users_friends = [];
      var amies1 = await FirebaseFirestore.instance
          .collection('friendship')
          .where('idUser2', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('validation', isEqualTo: true)
          .get();

      var amies2 = await FirebaseFirestore.instance
          .collection('friendship')
          .where('idUser1', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('validation', isEqualTo: true)
          .get();

      for (var i = 0; i < amies1.size; i++) {
        friendship.add(amies1.docs[i]['idUser1']);
      }

      for (var i = 0; i < amies2.size; i++) {
        friendship.add(amies2.docs[i]['idUser2']);
      }

      for (int i = 0; i < friendship.length; i++) {
        var temp = await FirebaseFirestore.instance
            .collection('users')
            .doc(friendship[i])
            .get();
        users_friends.add(temp);
      }
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
    setState(() {});
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
            'Création du nouveau groupe',
            style: TextStyle(color: Colors.white, fontSize: 19),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: users_friends.length,
          itemBuilder: (context, index) {
            bool cliquee = true;
            return Container(
              child: ListTile(
                title: Text(
                  users_friends[index]['name'],
                  style: TextStyle(
                      fontSize: 18.5,
                      fontWeight: FontWeight.bold,
                      backgroundColor: cliquee ? Colors.green : Colors.amber),
                ),
              ),
            );
          }),
    );
  }
}
