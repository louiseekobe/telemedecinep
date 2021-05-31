import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:medecineapp/accueil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreenPage(),
    );
  }
}

//SPLASH SCREEN DE L'APPLICATION
class SplashScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 13,
      navigateAfterSeconds: new Accueil(),
      backgroundColor: Colors.white,
      image: new Image.asset('img/doctorChar.gif'),
      loadingText: Text(
        "KAAY FAJUU ",
        style: TextStyle(
          color: Colors.blue,
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
      ),
      photoSize: 200.0,
      loaderColor: Colors.blue,
    );
  }
}
