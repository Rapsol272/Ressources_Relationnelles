import 'package:flutter/material.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:flutter_firebase/common/loading.dart';
import 'package:flutter_firebase/screens/authenticate/authenticate_screen.dart';

class Scroll extends StatelessWidget {
  const Scroll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget landscape() {
    return Center(child:Text('Hello'));
  }

  Widget portrait(){
    return 
        Center(child: Text('Portrait'),);  }

    return DraggableHome(
      title: Text("Ressources Relationnelles"),
      headerWidget: headerWidget(context),
      body: [
        AuthenticateScreen()
        /*OrientationBuilder(
                    builder: (context, orientation) {
                      if (orientation == Orientation.portrait){
                          return portrait();
                        } else if (orientation == Orientation.landscape){
                          return landscape();
                        } else {
                          return Loading();
                        }
                    })*/
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