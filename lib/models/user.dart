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
  //final String role;
  
  AppUserData({required this.uid, required this.name, required this.prenom, required this.date, required this.email}); //required this.role //required this.bio});
}