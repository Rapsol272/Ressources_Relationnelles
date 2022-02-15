

import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/pages/components/help/assist.dart';
import 'package:flutter_firebase/screens/pages/components/help/presentation.dart';
import 'package:flutter_firebase/screens/pages/components/help/sendMail.dart';
import 'package:flutter_firebase/screens/pages/components/help/signal.dart';

class Help extends StatefulWidget {
  Help({Key? key}) : super(key: key);

  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aide'),
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
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Presentation()));
                },
                leading: Icon(Icons.present_to_all),
                title: Text('Présentation de l\'application'),
              ),
           ),

          SizedBox(height: 10,),
           Card(
             child:ListTile(
                onTap: () {
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Assist()));
                },
                leading: Icon(Icons.all_inbox),
                title: Text('Espace d\'assistance'),
              ),
           ),

           SizedBox(height: 10,),
          
          Card(
            child:ListTile(
              onTap: () {
                 Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Signal()));
              },
              leading: Icon(Icons.report_problem),
              title: Text('Signaler un problème'),
            ),
           ),

           SizedBox(height: 10,),
          
        ],
      )
    );
  }
}