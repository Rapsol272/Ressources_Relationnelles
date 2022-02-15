import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/home/home_screen.dart';
import 'package:flutter_firebase/screens/pages/components/help.dart';
import 'package:flutter_firebase/widget/upBar.dart';

class Signal extends StatelessWidget {
  const Signal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: upBar(context, 'Ressources Relationnelles'),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child : Column(
        children: [
          Text('Signaler un problème', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          SizedBox(height: 100,),
          Column(
            children: [
              TextField(
            decoration: InputDecoration(
              label: Text('Votre signalement ici...'),
              hintMaxLines: 4
            ),
          ),
          SizedBox(height: 30,),
          ElevatedButton(
            onPressed: () {
              showDialog(context: context, 
              builder: (BuildContext context) => 
              AlertDialog(
                title: Text('Signaler un problème'),
                content: Text('Votre signalement a bien été envoyé !'),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    }, 
                    child: Text('Ok'))
                ],
              ),);
            }, 
            child: Text('Envoyer'))
          ],)
        ],
      ))
    );
  }
}