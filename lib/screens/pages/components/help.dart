import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/pages/components/help/sendMail.dart';

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
                onTap: () {},
                leading: Icon(Icons.all_inbox),
                title: Text('Espace d\'assistance'),
              ),
           ),

           SizedBox(height: 10,),
          
          Card(
            child:ListTile(
              onTap: () {
              },
              leading: Icon(Icons.report_problem),
              title: Text('Signaler un problème'),
            ),
           ),

           SizedBox(height: 10,),

          Card(
            child: ListTile(
              onTap: () {
                print('salut');
              },
                leading: Icon(Icons.support),
                title: Text('Page d\'aide'),
              ),
          ),
          
        ],
      )
    );
  }
}