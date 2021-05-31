import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medecineapp/models/user.dart';
import 'package:medecineapp/screens/authentificate/authentificate_medecin.dart';
import 'package:medecineapp/screens/home/home_medecin.dart';

class Medecin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    //Retourne soit homeMedecin soit authentification
    //en fonction de la valeur de user
    if (user == null) {
      return AuthentificateMedecin();
    } else {
      return HomeMedecin();
    }
  }
}
