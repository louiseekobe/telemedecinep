import 'package:flutter/material.dart';
import 'package:medecineapp/screens/authentificate/register_medecin.dart';
import 'package:medecineapp/screens/authentificate/sign_in_medecin.dart';

class AuthentificateMedecin extends StatefulWidget {
  @override
  _AuthentificateMedecinState createState() => _AuthentificateMedecinState();
}

class _AuthentificateMedecinState extends State<AuthentificateMedecin> {
  bool showSignIn = true;
  //PERMET DE MODIFIER L'ETAT DE LA VARIABLE showSignIn
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    //permet de switcher entre la page d'enregistrement et la page connexion
    if (showSignIn) {
      return SignInMedecin(toggleView: toggleView);
    } else {
      return RegisterMedecin(toggleView: toggleView);
    }
  }
}
