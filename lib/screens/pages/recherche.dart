import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/common/constants.dart';
import 'package:flutter_firebase/common/loading.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'dart:async';
import 'dart:math';

import 'package:search_page/search_page.dart';

class Search extends StatefulWidget {
  Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool _counter = false;
  bool isPressed = false;
  var isLiked = Icon(Icons.favorite, color: Colors.red,);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  

  static int refreshNum = 10; // number that changes when refreshed
  Stream<int> counterStream =
      Stream<int>.periodic(Duration(seconds: 1), (x) => refreshNum);

  @override
  Widget build(BuildContext context) {
    TextEditingController _textController = TextEditingController();
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff03989E ), Color(0xffF9E79F)])),
              child: 
    Scaffold(
      backgroundColor: Colors.transparent,
      key: _scaffoldKey,
      body: Center(
        child: TextField(
          style: TextStyle(
            color: Colors.white
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white24,
            border: UnderlineInputBorder(
            ),
            label: Text('Rechercher', style: TextStyle(color: greenMajor),),
          ),
          onTap: () {
            showSearch(context: context, delegate:CustomSearchDelegate());
          },
        )
      )
      /*StreamBuilder<int>(
            stream: counterStream,
            builder: (context, snapshot) {
              return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Loading();
          }
          return ListView(
            children: snapshot.data!.docs.map((document) {
            return Container(
            );
            }).toList(),
          );
        },);
            })*/));
  }
}

class CustomSearchDelegate extends SearchDelegate {
  
  
  List <String> searchTerms = [
    'Adrien',
    'Anthony',
    'Loic',
    'Baptiste',
    'Antoine',
    'Mendy'
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () {
        query = '';
      }, 
      icon: Icon(Icons.clear)
      )
    ];
  }

  @override
 Widget buildLeading(BuildContext context) {
    return 
      IconButton(onPressed: () {
        close(context, null);
      }, 
      icon: Icon(Icons.arrow_back_ios)
      );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var user in searchTerms) {
      if (user.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(user);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      }
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      }
    );
  }
}