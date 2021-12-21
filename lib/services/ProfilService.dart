import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilService {
  final FirebaseFirestore _firebaseFirestore =  FirebaseFirestore.instance;

  Future<String> get terms async {
    String content ='';
    DocumentReference documentReference =
    _firebaseFirestore.collection('infos').doc('content');

    content = (await documentReference.get()).get('content');

    return content;
  }
}