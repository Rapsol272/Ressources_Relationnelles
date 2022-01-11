import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/models/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService(this.uid);

  final CollectionReference<Map<String, dynamic>> userCollection =
      FirebaseFirestore.instance.collection("users");

  Future<void> saveUser(
      String firstname, String lastname, String date, String email) async {
    return await userCollection.doc(uid).set(
        {'name': firstname, 'prenom': lastname, 'date': date, 'email': email});
  }

  Future<void> saveToken(String? token) async {
    return await userCollection.doc(uid).set({'token': token});
  }

  AppUserData _userFromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data();
    if (data == null) throw Exception("user not found");
    return AppUserData(
        uid: snapshot.id,
        lastname: data['name'],
        firstname: data['prenom'],
        image: data['image'],
        date: data['date'],
        role: data['role'],
        about: data['bio'],
        email: data['email']);
  }

  Stream<AppUserData> get user {
    return userCollection.doc(uid).snapshots().map(_userFromSnapshot);
  }

  List<AppUserData> _userListFromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs.map((doc) {
      return _userFromSnapshot(doc);
    }).toList();
  }

  Stream<List<AppUserData>> get users {
    return userCollection.snapshots().map(_userListFromSnapshot);
  }
}
