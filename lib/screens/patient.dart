import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medecineapp/models/user.dart';
import 'package:medecineapp/screens/authentificate/authentificate_patient.dart';
import 'package:medecineapp/screens/home/home_patient.dart';

class Patient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    //Retourne soit homePatient soit authentification
    //en fonction de la valeur user
    if (user == null) {
      return AuthentificatePatient();
    } else {
      return HomePatient();
    }
  }
}
