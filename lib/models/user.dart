import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String uid;

  AppUser(this.uid);
}

class AppUserData {
  final String uid;
  final String name;
  final String prenom;
  final String date;
  final String email;
  final String role;
  final String about;
  final String image;

  const AppUserData(
      {required this.uid,
      required this.name,
      required this.prenom,
      required this.date,
      required this.role,
      required this.about,
      required this.image,
      required this.email});

  factory AppUserData.fromDocument(DocumentSnapshot doc) {
    return AppUserData(
        uid: doc['token'],
        prenom: doc['name'],
        email: doc['email'],
        date: doc['date'],
        role: doc['role'],
        name: doc['displayName'],
        image: doc['photoUrl'],
        about: doc['bio']);
  }
}
