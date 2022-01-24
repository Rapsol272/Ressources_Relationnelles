import 'package:flutter/material.dart';
import 'package:flutter_firebase/common/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:flutter_firebase/utils/user_preferences.dart';
import 'package:flutter_firebase/services/authentication.dart';
import 'package:flutter_firebase/widget/textfield_widget.dart';
import '../components/help.dart';
import '../components/params.dart';

class AddPostPage extends StatefulWidget {
  AddPostPage({Key? key}) : super(key: key);

  @override
  _AddPostPageState createState() => _AddPostPageState();
}

final AuthenticationService _auth = AuthenticationService();
Color _colorContainer1 = greenMajor;
Color _colorContainer2 = Color(0xffaefea01);
bool verif = true;

class _AddPostPageState extends State<AddPostPage> {
  AppUserData user = UserPreferences.myUser;
  String dropdownValue = 'Categorie';
  List<String> array = [
    'Code',
    'Sport',
    'Gastronomie',
    'Gaming',
    'Test1',
    'Barbie'
  ];

  Map<String, bool> array2 = {
    'Code': true,
    'Sport': true,
    'Gastronomie': true,
    'Gaming': true,
    'Test1': true,
    'Barbie': true,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barre verte d'action "Création du nouveau Post"
      appBar: AppBar(
        foregroundColor: Colors.black12,
        backgroundColor: greenMajor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        title: Title(
          color: Colors.white,
          child: Text(
            'Création du nouveau post',
            style: TextStyle(color: Colors.white, fontSize: 19),
            textAlign: TextAlign.center,
          ),
        ),
        actions: <Widget>[
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
                      context, MaterialPageRoute(builder: (context) => Help()));
                  break;
                // other cases...
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Row(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                        child: Icon(
                          Icons.settings,
                          color: greenMajor,
                        )),
                    Text('Paramètres')
                  ],
                ),
              ),
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                        child: Icon(
                          Icons.help,
                          color: greenMajor,
                        )),
                    Text('Aide')
                  ],
                ),
              ),
              PopupMenuItem(
                onTap: () async {},
                child: Row(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                        child: Icon(
                          Icons.edit,
                          color: greenMajor,
                        )),
                    Text('Modifier mon profil')
                  ],
                ),
              ),
              PopupMenuItem(
                onTap: () async {
                  await _auth.signOut();
                },
                child: Row(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                        child: Icon(
                          Icons.logout,
                          color: greenMajor,
                        )),
                    Text('Se déconnecter')
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      // Front de la page AddPostPage
      body: Container(
        padding: EdgeInsets.all(7),
        child: Flexible(
          child: Container(
            height: 1000,
            padding: EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: greenMajor.withOpacity(1),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    physics: BouncingScrollPhysics(),
                    children: [
                      const SizedBox(height: 24),
                      TextFieldWidget(
                        label: 'Titre',
                        text: 'Saisir votre titre',
                        onChanged: (title) {},
                      ),
                      const SizedBox(height: 24),
                      TextFieldWidget(
                        label: 'Contenu',
                        maxLines: 10,
                        text: 'Saisir le contenu ',
                        onChanged: (about) {},
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 30,
                      bottom: 10,
                      left: 30,
                      right: 30,
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Catégorie(s)',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (var i = 0; i < array2.length; i++)
                            unitPilCat(array2, i)
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      buttonStyle(238, Icons.publish_sharp),
                      // Ajout d'une image pour le post
                      buttonStyle(50, Icons.add_a_photo_outlined),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

unitPilCat(Map array, int i) {
  return Material(
    child: InkWell(
      onTap: () {
        array.values.elementAt(i) == true
            ? array.update(array.keys.elementAt(i), (value) => value = false)
            : array.update(array.keys.elementAt(i), (value) => value = true);
      }, // Handle your callback
      child: Ink(
        child: Container(
          margin: const EdgeInsets.only(right: 5, left: 5),
          padding:
              const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 1),
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                array.values.elementAt(i) == false
                    ? _colorContainer1
                    : Colors.black,
                array.values.elementAt(i) == false
                    ? _colorContainer2
                    : Colors.white,
              ],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                array.keys.elementAt(i),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

buttonStyle(double w, icon) {
  return Container(
    width: w,
    margin: const EdgeInsets.only(
      top: 10,
      bottom: 10,
      right: 30,
    ),
    decoration: BoxDecoration(
      color: greenMajor,
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(15),
        topLeft: Radius.circular(15),
        bottomRight: Radius.circular(15),
        bottomLeft: Radius.circular(15),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black38,
          spreadRadius: 1,
          blurRadius: 3,
          offset: Offset(0, 1), // changes position of shadow
        ),
      ],
    ),
    child: IconButton(
      onPressed: () {},
      iconSize: 25,
      icon: Icon(
        icon,
        color: Colors.white,
      ),
    ),
  );
}
