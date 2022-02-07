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
        print('Found file: $ref');
      },
    );
    return results;
  }

  Future<String> downloadUrl(String imageName) async {
    String downloadUrl =
        await storage.ref().child('images/$imageName').getDownloadURL();

    return downloadUrl;
  }
}
