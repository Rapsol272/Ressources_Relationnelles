import 'package:flutter/material.dart';
import 'package:flutter_firebase/widget/upBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


final usersRef = FirebaseFirestore.instance.collection('users');

class InfosPerso extends StatefulWidget {
  final String? uId;
  const InfosPerso({Key? key, required this.uId}) : super(key: key);

  @override
  State<InfosPerso> createState() => _InfosPersoState();
}

class _InfosPersoState extends State<InfosPerso> {
  var userData = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      var user = FirebaseAuth.instance.authStateChanges();

      isLoading = true;
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
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: upBar(context, 'Informations Personnelles'),
      body: SingleChildScrollView(
        child: Padding(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child:
          Column(
        children: [
          Card(
              child: ListTile(
                onTap: () {},
                title: Text('Nom'),
                subtitle: Text(userData['name']),
              ),
            ),
            SizedBox(height:20),
            Card(
              child: ListTile(
                onTap: () {},
                title: Text('Prénom'),
                subtitle: Text(userData['prenom']),
              ),
            ),
            SizedBox(height:20),
            Card(
              child: ListTile(
                onTap: () {},
                title: Text('Adresse mail'),
                subtitle: Text(userData['email']),
              ),
            ),
            SizedBox(height:20),
            Card(
              child: ListTile(
                onTap: () {},
                title: Text('Rôle'),
                subtitle: Text(userData['role']),
              ),
            ),
            SizedBox(height:20),
            Card(
              child: ListTile(
                onTap: () {},
                title: Text('Biographie'),
                subtitle: Text(userData['bio']),
              ),
            ),
            SizedBox(height:20),
            Card(
              child: ListTile(
                onTap: () {},
                title: Text('Modérateur'),
                subtitle: Text(userData['modo'].toString()),
              ),
            ),
            SizedBox(height:20),
            Card(
              child: ListTile(
                onTap: () {},
                title: Text('Administrateur'),
                subtitle: Text(userData['admin'].toString()),
              ),
            ),
        ],
      )
        ),
      )
    );
  }
}