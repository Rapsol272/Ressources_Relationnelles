import 'package:flutter/material.dart';
import 'package:flutter_firebase/widget/upBar.dart';

class Graphs extends StatefulWidget {
  Graphs({Key? key}) : super(key: key);

  @override
  State<Graphs> createState() => _GraphsState();
}

class _GraphsState extends State<Graphs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: upBar(context, 'Ressources Relationnelles'),
      );
  }
}