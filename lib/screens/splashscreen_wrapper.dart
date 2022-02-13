import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:flutter_firebase/screens/authenticate/authenticate_screen.dart';
import 'package:flutter_firebase/screens/authenticate/scrollAuth.dart';
import 'package:flutter_firebase/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

class SplashScreenWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var hasWidthPage = MediaQuery.of(context).size.width;
    final user = Provider.of<AppUser?>(context);
    if (user == null) {
      if (hasWidthPage < 600) {
        return ScrollAuth();
      }
      return Scaffold(body: AuthenticateScreen(),);
    } else {
      return HomeScreen(uId:
      FirebaseAuth.instance.currentUser!.uid,
      //'cY0qw9r4Q6WXiBQwuDvRYq:APA91bH0hbf1SYqFdsA93HifmTAVuc24eJ2A32AwjCJbWFhqrVqT3jYARDaCle_xhZSm7OPKqGORuqFsXz1b_58E5GU1TNaaaSnXU5DDACIUwy1S8koo-4t12RgaOztZuguYM27rWVeh'
      );
    }
  }
}
