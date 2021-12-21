import 'package:flutter/material.dart';
import 'package:flutter_firebase/common/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: greenMajor,
      child: Center(
        child: SpinKitChasingDots(
          color: or,
          size: 60.0,
        ),
      ),
    );
  }
}
