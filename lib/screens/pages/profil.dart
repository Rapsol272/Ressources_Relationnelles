import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:flutter_firebase/screens/pages/commentPage.dart';
import 'package:flutter_firebase/screens/pages/edit_profile.dart';
import 'package:flutter_firebase/utils/user_preferences.dart';
import 'package:flutter_firebase/widget/profile_widget.dart';
import 'package:flutter_firebase/widget/numbers_widgets.dart';
import 'package:flutter_firebase/screens/pages/bodyAcceuil.dart';
import 'package:flutter_firebase/common/constants.dart';

class Profil extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: user.image,
            onClicked: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => EditProfile()));
            },
          ),
          const SizedBox(height: 24),
          buildName(user),
          const SizedBox(height: 24),
          NumbersWidget(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

Widget buildName(AppUserData user) => Column(
      children: [
        Text(
          user.lastname,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        Text(
          user.firstname,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        const SizedBox(height: 4),
        Text(
          user.role,
          style: TextStyle(color: Colors.grey),
        )
      ],
    );
