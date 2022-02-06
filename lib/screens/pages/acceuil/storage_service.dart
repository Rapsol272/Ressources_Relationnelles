import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<String> uploadFile(String filePath, String fileName) async {
    File file = File(filePath);
    try {
      final TaskSnapshot snapshot =
          await storage.ref().child('$fileName').putFile(file);
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } on firebase_core.FirebaseException catch (e) {
      print(e);
      return '';
    }
  }

  Future<firebase_storage.ListResult> listFiles() async {
    firebase_storage.ListResult results =
        await storage.ref().child('images/').listAll();

    results.items.forEach(
      (
        firebase_storage.Reference ref,
      ) {
        print('Foud file: $ref');
      },
    );
    return results;
  }

  Future<bool> existLikeUser(String idPost, String idUser) async {
    List<String> lst = [];
    bool verif = false;
    await FirebaseFirestore.instance.collection('posts').get().then(
          (querySnapshot) => {
            querySnapshot.docs.forEach(
              (doc) => {
                if (doc.id == idUser) lst = doc["idLikeUsers"].cast<String>(),
              },
            ),
          },
        );
    for (int i = 0; i < lst.length; i++) {
      if (idPost == lst[i]) {
        verif = true;
      }
    }
    return verif;
  }

  Future<bool> changeLikePost(String idPost, String idUser, bool b) async {
    List<String> lst = [];
    bool verif = false;
    await FirebaseFirestore.instance.collection('posts').get().then(
          (querySnapshot) => {
            querySnapshot.docs.forEach(
              (doc) => {
                if (doc.id == idUser) lst = doc["idLikePost"].cast<String>(),
              },
            ),
          },
        );

    return verif;
  }

  /*// Pour vérifier si le document avec les paramètres ci-dessous, existe dans la collection like
  Future<bool> verifyLikePost(String idPost, String idUser) async {
    bool verif = false;
    await FirebaseFirestore.instance.collection('like').get().then(
          (querySnapshot) => {
            querySnapshot.docs.forEach(
              (doc) => {
                if (doc['idPost'] == idPost && doc['idUser'] == idUser)
                  verif = true,
              },
            ),
          },
        );
    return verif;
  }

  //
  Future<void> changeLikePost(String idPost, String idUser) async {
    bool verif = await verifyLikePost(idPost, idUser);
    if (verif == false) {
      var myData = {
        'idUser': idUser,
        'idPost': idPost,
      };
      var collection = FirebaseFirestore.instance.collection('like');
      collection
          .add(myData) // <-- Your data
          .then((_) => print('Added'))
          .catchError((error) => print('Add failed: $error'));
    } else {
      var collection = FirebaseFirestore.instance.collection('like');
      var snapshot = await collection
          .where('idPost', isEqualTo: idPost)
          .where('idPost', isEqualTo: idUser)
          .get();

      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }
    }
  } */
}
