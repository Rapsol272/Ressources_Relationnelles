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
  final bool mod;
  final bool admin;
  final String image;

  const AppUserData(
      {required this.uid,
      required this.name,
      required this.prenom,
      required this.role,
      required this.bio,
      required this.email,
      required this.mod,
      required this.admin,
      required this.image});

  factory AppUserData.fromDocument(DocumentSnapshot doc) {
    return AppUserData(
        uid: doc['token'],
        prenom: doc['prenom'],
        email: doc['email'],
        role: doc['role'],
        name: doc['name'],
        bio: doc['bio'],
        mod: doc['mod'],
        admin: doc['admin'],
        image: doc['image']
        );
  }
}
