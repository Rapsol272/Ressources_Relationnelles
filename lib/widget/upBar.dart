import 'package:flutter/material.dart';

upBar(context, String title) {
    return AppBar(
      
      title: Text(title),
      leading: IconButton(onPressed: () {Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios)),
    );
  }