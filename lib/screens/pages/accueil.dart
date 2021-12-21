import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/common/constants.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'dart:async';
import 'dart:math';

class Accueil extends StatefulWidget {
  Accueil({Key? key}) : super(key: key);

  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  bool _counter = false;
  bool isPressed = false;
  var isLiked = Icon(Icons.favorite, color: Colors.red,);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10; // number that changes when refreshed
  Stream<int> counterStream =
      Stream<int>.periodic(Duration(seconds: 1), (x) => refreshNum);

  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
  }

  Future<void> _handleRefresh() {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(seconds: 1), () {
      completer.complete();
    });
    setState(() {
      refreshNum = new Random().nextInt(100);
    });
    return completer.future.then<void>((_) {
      _scaffoldKey.currentState?.showSnackBar(SnackBar(
          content: const Text('Page rafraîchie'),
          action: SnackBarAction(
              label: 'Rafraîchie moi encore',
              onPressed: () {
                _refreshIndicatorKey.currentState!.show();
              })));
    });
  }
  @override
  Widget build(BuildContext context) {
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
      body: LiquidPullToRefresh(
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        showChildOpacityTransition: false,
        backgroundColor: or,
        color: Color(0xff009b9e),
        child: StreamBuilder<int>(
            stream: counterStream,
            builder: (context, snapshot) {
              return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
  
          return ListView(
            children: snapshot.data!.docs.map((document) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Card(
                  clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(),
                  title: Text(document['title']),
                  subtitle: Text(
                    document['auteur'],
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    document['content'],
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _counter = !_counter;
                        });
                      }, 
                      icon: _counter ? Icon(Icons.favorite, color: Colors.red,) : Icon(Icons.favorite_border_outlined, color: greenMajor)),
                    
                    IconButton(
                      onPressed: () {}, 
                      icon: Icon(Icons.comment_outlined)),
                    IconButton(
                      onPressed: () {}, 
                      icon: Icon(Icons.ios_share)),
                    
                  ],
                ),
              ],
            ),
          ),
                );
            }).toList(),
          );
        },);
            }))));
  }
}