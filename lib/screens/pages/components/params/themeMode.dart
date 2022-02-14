import 'package:flutter/material.dart';
import 'package:flutter_firebase/widget/upBar.dart';

class ModeTheme extends StatefulWidget {
  ModeTheme({Key? key}) : super(key: key);

  @override
  State<ModeTheme> createState() => _ModeThemeState();
}

class _ModeThemeState extends State<ModeTheme> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: upBar(context, 'Ressources Relationnelles'),
      body: Column(
        children: [
          Text('Changez de thème :'),
          SizedBox(height: 30,),
          IconButton(
            onPressed: () {
              Theme.of(context).brightness == Brightness.light
              ? Theme.of(context).brightness
              : Theme.of(context).brightness;
            }, 
            icon: Icon(Theme.of(context).brightness == Brightness.light
            ? Icons.brightness_4
            : Icons.brightness_high)),
        ],
      ),
    );
  }
}