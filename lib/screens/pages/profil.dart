import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/chat_params.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:flutter_firebase/services/database.dart';
import 'package:provider/provider.dart';
import '../../services/ProfilService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilService {
  final FirebaseFirestore _firebaseFirestore =  FirebaseFirestore.instance;

}

class Profil extends StatefulWidget {
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
   final users = Provider.of<List<AppUserData>>(context);
    return  StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        } else {
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return Infos(users[index]);
            });
          }
      },);
  }
}

class Infos extends StatelessWidget {
  final AppUserData user;

  Infos(this.user);

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<AppUser?>(context);
    if (currentUser == null) throw Exception("current user not found");
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff03989E ), Color(0xffF9E79F)])),
              child: 
    Scaffold(
      backgroundColor: Colors.transparent,
     body:  Padding(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Card(
                  clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.arrow_drop_down_circle),
                  title: Text('${user.name}'),
                  subtitle: Text(
                    'prenom',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'email',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
              ],
            ),
          ),
        )));
    
    
    
  }
}