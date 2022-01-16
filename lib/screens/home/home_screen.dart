import 'package:flutter/material.dart';
import 'package:flutter_firebase/common/constants.dart';
import 'package:flutter_firebase/common/loading.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:flutter_firebase/screens/authenticate/confirmation.dart';
import 'package:flutter_firebase/screens/pages/accueil.dart';
import 'package:flutter_firebase/screens/pages/bodyAcceuil.dart';
import 'package:flutter_firebase/screens/pages/commentPage.dart';
import 'package:flutter_firebase/screens/pages/edit_profile.dart';
import 'package:flutter_firebase/screens/pages/groupes.dart';
import 'package:flutter_firebase/screens/pages/profil.dart';
import 'package:flutter_firebase/screens/pages/recherche.dart';
import 'package:flutter_firebase/services/authentication.dart';
import 'package:flutter_firebase/services/database.dart';
import 'package:flutter_firebase/services/notification_service.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomeScreen extends StatefulWidget {
  final AuthenticationService _auth = AuthenticationService();
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _currentIndex = 0;
  final List<Widget> _pages = [
    isCommentPost == false ? Accueil() : commentPage(),
    Groupes(),
    Search(),
    Profil(),
  ];
  final AuthenticationService _auth = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    NotificationService.initialize();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Ressources Relationnelles',
          style: TextStyle(color: greenMajor),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.logout,
              color: greenMajor,
            ),
            onPressed: () async {
              await _auth.signOut();
            },
          )
        ],
      ),
      body: //UserList(),
          _pages[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          /// Accueil
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text("Accueil"),
            selectedColor: greenMajor,
          ),

          /// Mes groupes
          SalomonBottomBarItem(
            icon: Icon(Icons.groups),
            title: Text("Mes groupes"),
            selectedColor: or,
          ),

          /// Recherche
          SalomonBottomBarItem(
            icon: Icon(Icons.search),
            title: Text("Recherche"),
            selectedColor: greenMajor,
          ),

          /// Mon profil
          SalomonBottomBarItem(
            icon: Icon(Icons.person),
            title: Text("Mon profil"),
            selectedColor: or,
          ),
        ],
      ),
    );
  }
}
