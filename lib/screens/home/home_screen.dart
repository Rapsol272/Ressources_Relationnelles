import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/common/constants.dart';
import 'package:flutter_firebase/services/searchDelagate.dart';
import 'package:flutter_firebase/screens/pages/accueil.dart';
import 'package:flutter_firebase/screens/pages/components/help.dart';
import 'package:flutter_firebase/screens/pages/components/params.dart';
import 'package:flutter_firebase/screens/pages/dashboard/dashboard.dart';
import 'package:flutter_firebase/screens/pages/profil/edit_profile.dart';
import 'package:flutter_firebase/screens/pages/groupes.dart';
import 'package:flutter_firebase/screens/pages/profil/profil.dart';
import 'package:flutter_firebase/services/authentication.dart';
import 'package:flutter_firebase/services/notification_service.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';




class HomeScreen extends StatefulWidget {
  
  HomeScreen({Key? key, required this.uId}) : super(key: key);
  final String? uId;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var userData = {};
  bool isLoading = true;
  

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      var user = FirebaseAuth.instance.authStateChanges();

      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uId)
          .get();

      userData = userSnap.data()!;
      setState(() {});
    } catch (e) {
      showSnackBar(BuildContext context, String text) {
        return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(text),
          ),
        );
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  
  var _currentIndex = 0;
  bool mod = true;
  final List<Widget> _pages = [
    Accueil(uId: FirebaseAuth.instance.currentUser!.uid),
    Groupes(),
    Profil(uId: FirebaseAuth.instance.currentUser!.uid),
  ];
  final AuthenticationService _auth = AuthenticationService();
  TextEditingController textController = TextEditingController();

  

  @override
  Widget build(BuildContext context) {
    var hasWidthPage = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: greenMajor,
        elevation: 0.0,
        title: Text(
          'Ressources Relationnelles',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
        onPressed: () {
          showSearch(
            context: context, 
            delegate: CustomSearchDelegate());
        },
        icon: Icon(Icons.search)),
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onSelected: (choice) {
              switch (choice) {
                case 0:
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Params()));
                  break;
                case 1:
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => (userData['admin']==true) ? Dashboard() : Help()));
                  break;
                case 2:
                (userData['name'] == null)
                  ? _auth.signOut()
                  : Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                          EditProfile(
                                currentUserUid:
                                    FirebaseAuth.instance.currentUser!.uid,
                              )));
                  
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
                          (userData['admin']==true) ?
                          Icons.dashboard : Icons.help,
                          color: greenMajor,
                        )),
                    Text((userData['admin']==true) ? 'Tableau de bord' : 'Aide')
                  ])),
                  PopupMenuItem(
                  value: 2,
                  child: Row(children: <Widget>[
                    Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                        child: Icon(
                          (userData['name'] == null)
                          ? Icons.person_add
                          : Icons.edit,
                          color: greenMajor,
                        )),
                    Text((userData['name'] == null) ? 'Créer un compte' : 'Modifier mon profil')
                  ])),
              PopupMenuItem(
                  onTap: () async {
                    await _auth.signOut();
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
      body:
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
          

          /// Mon profil
          SalomonBottomBarItem(
            icon: CircleAvatar(
              backgroundImage:AssetImage('images/ressources_relationnelles.png'),
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
