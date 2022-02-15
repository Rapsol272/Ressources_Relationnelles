
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/common/constants.dart';
import 'package:flutter_firebase/screens/pages/dashboard/commentsList.dart';
import 'package:flutter_firebase/screens/pages/dashboard/postsList.dart';
import 'package:flutter_firebase/screens/pages/dashboard/usersList.dart';
import 'package:flutter_firebase/widget/upBar.dart';

class Dashboard extends StatefulWidget {
  
  Dashboard({Key? key, required this.uId}) : super(key: key);
  final String? uId;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  var userData = {};
  int postLen = 0;

getUserL() async {
  var usersLen = FirebaseFirestore.instance
    .collection('users')
    .get()
    .then((QuerySnapshot userL) {
        userL.docs.forEach((doc) {
            print(doc["name"]);
        });
    });


}
 
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: upBar(context, 'Ressources Relationnelles'),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Text('Utilitaires', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Column(
            children: [
              Card(
                color: Colors.grey[100],
                shadowColor: greenMajor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  onTap: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UsersList()));
                  },
                  title: Text('Tous les utilisateurs'),
                  leading: Container(
                    width: 40, 
                    height: 40,
                    decoration: BoxDecoration(
                      color:greenMajor,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Icon(Icons.person, color: Colors.white,),),),
              ),
              SizedBox(height: 10,),
              Card(
                color: Colors.grey[100],
                shadowColor: greenMajor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  onTap: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PostsList()));
                  },
                  title: Text('Tous les posts'),
                  leading: Container(
                    width: 40, 
                    height: 40,
                    decoration: BoxDecoration(
                      color:greenMajor,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Icon(Icons.post_add,color: Colors.white,),),),
              ),
              SizedBox(height: 10,),
              Card(
                color: Colors.grey[100],
                shadowColor: greenMajor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  onTap: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CommentsList()));
                  },
                  title: Text('Tous les commentaires'),
                  leading: Container(
                    width: 40, 
                    height: 40,
                    decoration: BoxDecoration(
                      color:greenMajor,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Icon(Icons.comment, color: Colors.white,),),),
              )
            ],
          ),),

         Padding(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Text('Statistiques', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 150, 
                    height: 250,
                    decoration: BoxDecoration(
                      color:greenMajor,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        getUserL();
                      }, 
                      child: Text('TEst'))
              ),
              Container(
                width: 150, 
                    height: 250,
                    decoration: BoxDecoration(
                      color:greenMajor,
                      borderRadius: BorderRadius.circular(10)
                    ),
              )
            ],
          )
        ],
      ),
    );
  }
}