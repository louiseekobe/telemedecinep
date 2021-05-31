import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color c3 = const Color.fromRGBO(46, 112, 206, 1.0);
    return Container(
      color: Colors.white, //definir la meme couleur que le background
      child: Center(
        //permet de definir le type d'animation qu'on aurra avec le package spinkit
        child: SpinKitCircle(
          color: c3,
          size: 50.0,
        ),
      ),
    );
  }
}
