import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase/screens/pages/components/params/infosPerso.dart';
import 'package:flutter_firebase/widget/profile_widget.dart';
import 'package:flutter_firebase/common/constants.dart';
import 'package:flutter_firebase/screens/pages/acceuil/storage_service.dart';
import 'package:flutter_firebase/widget/upBar.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:flutter_firebase/screens/home/home_screen.dart';
import 'package:flutter_firebase/screens/pages/acceuil/storage_service.dart';
import 'package:flutter_firebase/screens/pages/accueil.dart';
import 'package:flutter_firebase/screens/pages/acceuil/bodyAccueil.dart';
import 'package:flutter_firebase/screens/pages/profil/profil.dart';

final usersRef = FirebaseFirestore.instance.collection('users');

class EditProfile extends StatefulWidget {
  final String currentUserUid;
  EditProfile({required this.currentUserUid});
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  //AppUserData user = UserPreferences.myUser;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  final reference = '';
  bool isLoading = false;
  late AppUserData user_fire;
  bool _displayNameValid = true;
  bool _bioValid = true;
  var _path;
  var _fileName;
  final Storage storage = Storage();

  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser() async {
    setState(() {
      isLoading = true;
    });
    DocumentSnapshot doc = await usersRef.doc(widget.currentUserUid).get();
    user_fire = AppUserData.fromDocument(doc);
    nameController.text = user_fire.name;
    prenomController.text = user_fire.prenom;
    bioController.text = user_fire.bio;
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: upBar(context, 'Ressources Relationnelles'),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 32),
          physics: BouncingScrollPhysics(),
          children: [
            ProfileWidget(
                imagePath: '',
                isEdit: true,
                onClicked: () {
                  storage.uploadFile(_path, _fileName);
                }),
            const SizedBox(height: 24),
            Text(
              'Nom',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            buildNameField(),
            const SizedBox(height: 24),
            Text(
              'Prénom',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            buildPrenomField(),
            const SizedBox(height: 24),
            Text(
              'Rôle',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            buildBioField(),
            const SizedBox(height: 24),
            buildImgField(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xff148F77),
                onPrimary: Colors.white,
                shadowColor: Colors.greenAccent,
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                minimumSize: Size(200, 40),
              ),
              child: Text(
                "Sauvegarder",
              ),
              onPressed: () async {
                await updateProfileData();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen(
                              uId: FirebaseAuth.instance.currentUser!.uid,
                            )));
              },
            ),
          ],
        ),
      );

  Column buildNameField() {
    return Column(
      children: [
        const SizedBox(height: 8),
        TextField(
          controller: nameController,
          decoration: InputDecoration(
            label: Text('Votre Nom'),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          maxLines: 1,
        ),
      ],
    );
  }

  Column buildPrenomField() {
    return Column(
      children: [
        const SizedBox(height: 8),
        TextField(
          controller: prenomController,
          decoration: InputDecoration(
            label: Text('Votre Prenom'),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          maxLines: 1,
        ),
      ],
    );
  }

  Column buildBioField() {
    return Column(
      children: [
        const SizedBox(height: 8),
        TextField(
          controller: bioController,
          decoration: InputDecoration(
            label: Text('Votre Biographie'),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          maxLines: 1,
        ),
      ],
    );
  }

  Column buildImgField() {
    return Column(
      children: [
        OutlinedButton(
            style: OutlinedButton.styleFrom(
              primary: greenMajor,
              backgroundColor: Colors.transparent,
              side: BorderSide(color: greenMajor, width: 1),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
            onPressed: () async {
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
              print(_fileName);
            },
            child: Text('Ajouter une image'))
      ],
    );
  }

  updateProfileData() {
    setState(() {
      nameController.text.trim().length < 3 || nameController.text.isEmpty
          ? _displayNameValid = false
          : _displayNameValid = true;

      bioController.text.trim().length > 100
          ? _bioValid = false
          : _bioValid = true;
    });

    if (_displayNameValid && _bioValid) {
      usersRef.doc(widget.currentUserUid).update({
        "name": nameController.text,
        "prenom": prenomController.text,
        "bio": bioController.text,
        "reference": storage.uploadFile(_path, _fileName),
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Votre profil a été modifié")));
    }
  }
}
