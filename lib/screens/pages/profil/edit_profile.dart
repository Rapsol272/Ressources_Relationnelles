import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:flutter_firebase/screens/pages/profil/profil.dart';
import 'package:flutter_firebase/utils/user_preferences.dart';
import 'package:flutter_firebase/widget/appbar_widget.dart';
import 'package:flutter_firebase/widget/profile_widget.dart';
import 'package:flutter_firebase/widget/textfield_widget.dart';

class EditProfile extends StatefulWidget {
  final String currentUserUid;
  EditProfile({required this.currentUserUid});
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  AppUserData user = UserPreferences.myUser;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  bool isLoading = false;
  late AppUserData user_fire;
  bool _displayNameValid = true;
  bool _bioValid = true;

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
    bioController.text = user_fire.about;
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: buildAppBar(context),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 32),
          physics: BouncingScrollPhysics(),
          children: [
            ProfileWidget(
                imagePath: user.image, isEdit: true, onClicked: () async {}),
            const SizedBox(height: 24),
            buildNameField(),
            const SizedBox(height: 24),
            buildBioField(),
            const SizedBox(height: 24),
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
              onPressed: () {
                updateProfileData;
                //Navigator.pop(context);
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
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          maxLines: 1,
        ),
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

    if (_displayNameValid /* && _bioValid */) {
      usersRef.doc(widget.currentUserUid).update({
        "name": nameController.text, /* "bio": bioController.text */
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Votre profil a été modifié")));
    }
  }
}
