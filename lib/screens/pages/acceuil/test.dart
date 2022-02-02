import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/common/constants.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:flutter_firebase/screens/pages/acceuil/commentPage.dart';
import 'package:flutter_firebase/screens/pages/profil.dart';
import 'package:flutter_firebase/services/authentication.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';

class Test extends StatefulWidget {
  Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  late File imageFile;
  late String url;
  bool created = false;

  Future<String> _openGallery(BuildContext context) async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    File selected = File(pickedFile!.path);
    setState(() {
      imageFile = selected;
    });
    String fileName = imageFile.path;
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('images/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);

    uploadTask.whenComplete(() async {
      String test = await firebaseStorageRef.getDownloadURL();
    });

    return test;
  }

  //Future uploadImageToFirebase(BuildContext context) async {

  //}

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      height: 500,
      width: 500,
      child: Column(
        children: [
          IconButton(
            onPressed: () {
              url = _openGallery(context) as String;
              created = true;
            },
            icon: Icon(Icons.ac_unit_sharp),
            color: Colors.white,
          ),
          created
              ? Image.network(
                  url,
                )
              : Container(
                  color: Colors.red,
                  height: 50,
                  width: 300,
                ),
        ],
      ),
    );
  }
}
