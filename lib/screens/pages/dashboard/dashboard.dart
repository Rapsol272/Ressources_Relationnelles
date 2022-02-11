import 'package:flutter/material.dart';
import 'package:flutter_firebase/common/constants.dart';
import 'package:flutter_firebase/screens/pages/dashboard/usersList.dart';
import 'package:flutter_firebase/widget/upBar.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: upBar(context, 'Ressources Relationnelles'),
      body: Column(
        children: [
          Row(
            children: [
              Text('Utilitaires'),
              Text('See all')
            ],
          ),

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

          Row(
            children: [
              Text('Statistiques')
            ],
          ),

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