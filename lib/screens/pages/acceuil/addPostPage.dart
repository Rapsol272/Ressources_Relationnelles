import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/common/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:flutter_firebase/screens/home/home_screen.dart';
import 'package:flutter_firebase/screens/pages/acceuil/storage_service.dart';
import 'package:flutter_firebase/utils/user_preferences.dart';
import 'package:flutter_firebase/services/authentication.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class AddPostPage extends StatefulWidget {
  AddPostPage({Key? key}) : super(key: key);

  @override
  _AddPostPageState createState() => _AddPostPageState();
}

final AuthenticationService _auth = AuthenticationService();
Color _colorContainer1 = greenMajor;
Color _colorContainer2 = Color(0xffaefea01);
bool verif = true;

var _path;
var _fileName;
final Storage storage = Storage();

class _AddPostPageState extends State<AddPostPage> {
  AppUserData user = UserPreferences.myUser;
  String dropdownValue = 'Categorie';
  String lastKey = '';
  String myTitle = '';
  String myContent = '';
  var name = '';
  var prenom = '';
  var currentColor = Color(0xff03989E);

  var myUserId = FirebaseAuth.instance.currentUser!.uid;
  var myControllerTitle = TextEditingController();
  var myControllerContent = TextEditingController();

  List<String> array = [];

  // Categorie possible de post
  Map<String, bool> array2 = {
    'Code': false,
    'Gastronomie': false,
    'Sciences': false,
    'Gaming': false,
    'Sport': false,
    'Film': false,
    'Technologies': false,
  };

  // Charge les données de l'utilisateur courant nécessaire avant de construire le widget
  getData() async {
    await FirebaseFirestore.instance.collection('users').get().then(
          (querySnapshot) => {
            querySnapshot.docs.forEach(
              (doc) => {
                if (doc.id == myUserId)
                  if (doc.data()['name'] != null)
                    {
                      name = doc.data()['name'],
                      prenom = doc.data()['prenom'],
                    }
              },
            )
          },
        );
  }

  initArray2() async {
    for (var i = 0; i < array.length; i++) {
      array2[array[i]] = false;
    }
  }

  // Retourne la list des tags sélectionnés
  List getTags() {
    var myList = [];
    for (var i = 0; i < array2.length; i++) {
      if (array2.values.elementAt(i) == true)
        myList.add(array2.keys.elementAt(i));
    }
    return myList;
  }

  // Verifie le nombre de catégorie qui ont été choisi par user courant
  verifNumberCat() {
    var n = 0;
    for (var i = 0; i < array2.length; i++) {
      if (array2.values.elementAt(i) == true) n += 1;
    }
    if (n < 4)
      return true;
    else
      return false;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myControllerTitle.dispose();
    myControllerContent.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

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
                      txtEditingCont('Titre', 1),
                      const SizedBox(height: 24),
                      txtEditingCont('Contenu', 10),
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
                  Container(
                    margin: const EdgeInsets.only(
                      top: 15,
                      bottom: 10,
                      left: 30,
                      right: 30,
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Image',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: _path == null
                        ? Container()
                        : Image.file(
                            File(_path),
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      buttonStyle(238, Icons.publish_sharp),
                      // Ajout d'une image pour le post
                      buttonStyle(50, Icons.add_a_photo_outlined),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Create choice categorie for new post
  unitPilCat(Map array, int i) {
    return Material(
      child: InkWell(
        onTap: () {
          // Code to setup only 3 categories choice
          if (verifNumberCat()) {
            setState(() {
              array.values.elementAt(i) == true
                  ? array.update(
                      array.keys.elementAt(i), (value) => value = false)
                  : array.update(
                      array.keys.elementAt(i), (value) => value = true);
              lastKey = array.keys.elementAt(i);
            });
          } else {
            setState(() {
              array.update(lastKey, (value) => value = false);
              array.update(array.keys.elementAt(i), (value) => value = true);
              lastKey = array.keys.elementAt(i);
            });
          }
        },
        // Front button categories
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
                  array.values.elementAt(i) == true
                      ? _colorContainer1
                      : Colors.black,
                  array.values.elementAt(i) == true
                      ? _colorContainer2
                      : Colors.white,
                ],
              ),
            ),
            // Text du nom de la catégorie
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

  // Textfield avec controller, pour récupérer les champs
  txtEditingCont(String label, int max) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        TextField(
          controller:
              label == 'Titre' ? myControllerTitle : myControllerContent,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          maxLines: max,
        ),
      ],
    );
  }

  // Les boutons en fin de page pour finir la création d'un post
  buttonStyle(double w, icon) {
    return Container(
      width: w,
      margin: const EdgeInsets.only(
        top: 10,
        bottom: 10,
        right: 30,
      ),
      decoration: BoxDecoration(
        color: currentColor,
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
        onPressed: () async {
          if (icon == Icons.publish_sharp &&
              verifNumberCat() &&
              _fileName != null) {
            var myData = {
              'idUser': myUserId,
              'auteur': prenom + ' ' + name,
              'content': myControllerContent.text,
              'dateCreation': DateTime.now(),
              'title': myControllerTitle.text,
              'reference': await storage.uploadFile(_path, _fileName),
              'tags': getTags(),
            };
            var collection = FirebaseFirestore.instance.collection('posts');
            collection
                .add(myData) // <-- Your data
                .then((_) => print('Added'))
                .catchError((error) => print('Add failed: $error'));

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            );
          } else if (icon == Icons.publish_sharp) {
            setState(() {
              currentColor = Color(0xffb72c1c);
            });
          } else if (icon == Icons.add_a_photo_outlined) {
            final results = await FilePicker.platform.pickFiles(
              allowMultiple: false,
              type: FileType.custom,
              allowedExtensions: ['png', 'jpg'],
            );

            if (results == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('No file'),
                ),
              );
              return null;
            }

            final path = results.files.single.path!;
            _path = path;
            final fileName = results.files.single.name;
            _fileName = fileName;
            setState(() {});
          }
        },
        iconSize: 25,
        icon: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
