import 'package:flutter/material.dart';
import 'package:flutter_firebase/common/constants.dart';

class Accueil extends StatelessWidget {
  const Accueil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    Widget portrait() {
      return Center(
        child: Text('Portrait'),
      );
    }

    Widget landscape() {
      return Center(
        child: Text('Landscape'),
      );
    }

    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait){
            return portrait();
          } else {
            return landscape();
          }
        })
      );
  }
}