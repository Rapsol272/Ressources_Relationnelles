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
<<<<<<< HEAD
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
=======
  //final String role;
  
  AppUserData({required this.uid, required this.name, required this.prenom, required this.date, required this.email}); //required this.role //required this.bio});
}
>>>>>>> origin/main
