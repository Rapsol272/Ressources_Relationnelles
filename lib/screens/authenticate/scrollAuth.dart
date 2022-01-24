import 'package:flutter/material.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:flutter_firebase/screens/authenticate/authenticate_screen.dart';

class ScrollAuth extends StatelessWidget {
  const ScrollAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      title: Text('Ressources Relationnelles'), 
      headerWidget: Center(child:Image.asset('images/ressources_relationnelles_transparent.png')), 
      body: [
        AuthenticateScreen()
      ],
      fullyStretchable: false,
      );
  }
}