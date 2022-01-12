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
}
