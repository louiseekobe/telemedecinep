import 'package:flutter/material.dart';
import 'package:medecineapp/screens/authentificate/register_patient.dart';
import 'package:medecineapp/screens/authentificate/sign_in_patient.dart';

class AuthentificatePatient extends StatefulWidget {
  @override
  _AuthentificatePatientState createState() => _AuthentificatePatientState();
}

class _AuthentificatePatientState extends State<AuthentificatePatient> {
  bool showSignIn = true;
  //PERMET DE MODIFIER L'ETAT DE LA VARIABLE showSignIn
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    //permet de switcher entre la page d'enregistrement et la page connexion
    if (showSignIn) {
      return SignInPatient(toggleView: toggleView);
    } else {
      return RegisterPatient(toggleView: toggleView);
    }
  }
}
