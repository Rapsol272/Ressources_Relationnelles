import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/widget/upBar.dart';
import 'package:flutter_firebase/screens/pages/components/params/donnes.dart';
import 'package:flutter_firebase/screens/pages/components/params/infosPerso.dart';


class Params extends StatefulWidget {
  Params({Key? key}) : super(key: key);

  @override
  _ParamsState createState() => _ParamsState();
}

class _ParamsState extends State<Params> {

  bool light = true;
  void changeLight() {
      setState(() {
        light = !light;
      });
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: upBar(context, 'Paramètres'),
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => InfosPerso(uId: FirebaseAuth.instance.currentUser!.uid)));
                },
                leading: Icon(Icons.person_outline),
                title: Text('Informations Personelles'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              child: ListTile(
                onTap: () {},
                leading: Icon(Icons.security),
                title: Text('Changez votre mot de passe'),
              ),
            ),

            SizedBox(height: 10,),

         Card(
           child:  ListTile(
              onTap: () {
                
              },
            leading: Icon(Icons.verified),
            title: Text('Thème Sombre'),
            trailing: IconButton(
            onPressed: () {
              setState(() {
                light = !light;
              });
            }, 
            icon: Icon( (light == true)
            ? Icons.toggle_off
            : Icons.toggle_on, color: (light == true) ? Colors.red : Colors.green,), iconSize: 50,),
            
          ),
         ),

            SizedBox(
              height: 10,
            ),
            Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Donnees()));
                },
                leading: Icon(Icons.analytics),
                title: Text('Politique d\'utilisation des données'),
              ),
          ),

       ],
      )
    );
  }
  
}

