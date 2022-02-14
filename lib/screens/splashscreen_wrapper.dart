import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:flutter_firebase/screens/authenticate/scrollAuth.dart';
import 'package:flutter_firebase/screens/authenticate_screen.dart';
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
      return Scaffold(
        body: AuthenticateScreen(),
      );
    } else {
      return HomeScreen();
    }
  }
}
