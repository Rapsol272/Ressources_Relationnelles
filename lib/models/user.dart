class AppUser {
  final String uid;

  AppUser(this.uid);
}

class AppUserData {
  final String uid;
  final String firstname;
  final String lastname;
  final String date;
  final String email;
  final String image;
  final String role;

  const AppUserData(
      {required this.uid,
      required this.firstname,
      required this.lastname,
      required this.date,
      required this.email,
      required this.image,
      required this.role});
}
