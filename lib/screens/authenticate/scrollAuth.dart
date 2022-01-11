import 'package:flutter/material.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:flutter_firebase/screens/authenticate/authenticate_screen.dart';

class Scroll extends StatelessWidget {
  const Scroll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      title: Text("Ressources Relationnelles"),
      headerWidget: headerWidget(context),
      body: [
        AuthenticateScreen(),
      ],
      fullyStretchable: false,
    );
  }

  

  Container headerWidget(BuildContext context) => Container(
        child: Center(
          child: Image.asset('images/ressources_relationnelles_transparent.png')
        ),
      );
}