import 'package:flutter/material.dart';
import 'package:flutter_firebase/common/constants.dart';
import 'package:flutter_switch/flutter_switch.dart';

class Params extends StatefulWidget {
  Params({Key? key}) : super(key: key);

  @override
  _ParamsState createState() => _ParamsState();
}

class _ParamsState extends State<Params> {
  bool status8 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paramètres'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          }, 
          icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
           Card(
             child:ListTile(
                onTap: () {},
                leading: Icon(Icons.person_outline),
                title: Text('Informations Personelles'),
              ),
           ),

           SizedBox(height: 10,),
          
          Card(
            child:ListTile(
              onTap: () {

              },
              leading: Icon(Icons.security),
              title: Text('Changez votre mot de passe'),
            ),
           ),

           SizedBox(height: 10,),

          Card(
            child: ListTile(
              onTap: () {
                print('salut');
              },
                leading: Icon(Icons.analytics),
                title: Text('Politique d\'utilisation des données'),
              ),
          ),

          SizedBox(height: 10,),

         Card(
           child:  ListTile(
              onTap: () {
                print('salut');
              },
            leading: Icon(Icons.verified),
            title: Text('Standard de la communautés'),
          ),
         ),
          
        ],
      )
    );
  }
}