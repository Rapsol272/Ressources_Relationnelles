import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilService {
  final FirebaseFirestore _firebaseFirestore =  FirebaseFirestore.instance;

  Future<String> get terms async {
    String content ='';
    DocumentReference documentReference =
    _firebaseFirestore.collection('users').doc('name');

    content = (await documentReference.get()).get('name');

    return content;
  }
}