import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String uid;

  AppUser(this.uid);
}

class AppUserData {
  final String uid;
  final String name;
  final String prenom;
  final String email;
  final String role;
  final String bio;
  final bool modo;
  final bool admin;

  const AppUserData(
      {required this.uid,
      required this.name,
      required this.prenom,
      required this.role,
      required this.bio,
      required this.email,
      required this.modo,
      required this.admin});

  factory AppUserData.fromDocument(DocumentSnapshot doc) {
    return AppUserData(
        uid: doc['token'],
        prenom: doc['prenom'],
        email: doc['email'],
        role: doc['role'],
        name: doc['name'],
        bio: doc['bio'],
        modo: doc['modo'],
        admin: doc['admin']);
  }
}
