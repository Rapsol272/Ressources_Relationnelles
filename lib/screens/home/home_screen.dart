import 'package:flutter/material.dart';
import 'package:flutter_firebase/common/constants.dart';
import 'package:flutter_firebase/common/loading.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:flutter_firebase/screens/authenticate/scrollAuth.dart';
import 'package:flutter_firebase/screens/pages/accueil.dart';
import 'package:flutter_firebase/screens/pages/components/help.dart';
import 'package:flutter_firebase/screens/pages/components/params.dart';
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
    Accueil(),
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
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
              color: greenMajor,
            ),
            onSelected: (choice) {
              switch (choice) {
                case 0:
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Params()));
                  break;
                case 1:
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Help()));
                  break;
                case 2:
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EditProfile()));
                // other cases...
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                  value: 0,
                  child: Row(children: <Widget>[
                    Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                        child: Icon(
                          Icons.settings,
                          color: greenMajor,
                        )),
                    Text('Paramètres')
                  ])),
              PopupMenuItem(
                  value: 1,
                  child: Row(children: <Widget>[
                    Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                        child: Icon(
                          Icons.help,
                          color: greenMajor,
                        )),
                    Text('Aide')
                  ])),
              PopupMenuItem(
                  value: 2,
                  child: Row(children: <Widget>[
                    Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                        child: Icon(
                          Icons.edit,
                          color: greenMajor,
                        )),
                    Text('Modifier mon profil')
                  ])),
              PopupMenuItem(
                  onTap: () async {
                    await _auth.signOut();
                    //await _auth.deleteUser();
                  },
                  child: Row(children: <Widget>[
                    Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                        child: Icon(
                          Icons.logout,
                          color: greenMajor,
                        )),
                    Text('Se déconnecter')
                  ]))
            ],
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
            icon: CircleAvatar(
              backgroundImage:
                  AssetImage('images/ressources_relationnelles.png'),
            ),
            //Icon(Icons.person),
            title: Text("Mon profil"),
            selectedColor: or,
          ),
        ],
      ),
    );
  }
}
