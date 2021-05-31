import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medecineapp/screens/home/methode_crud.dart';
import 'package:medecineapp/screens/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medecineapp/shared/constant.dart';

class Parametre extends StatefulWidget {
  @override
  _ParametreState createState() => _ParametreState();
}

class _ParametreState extends State<Parametre> {
  String nomP;
  String prenomP;
  String emailP;
  String telephoneP;
  String adresseP;

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser utilisateur;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    utilisateur = await _auth.currentUser();

    if (utilisateur != null) {
      GetCurrentUserDataP(idutilisateur: utilisateur.uid)
          .donneeUtilisateur
          .forEach((snapshot) {
        setState(() {
          this.nomP = snapshot.nom;
          this.emailP = snapshot.email;
          this.prenomP = snapshot.prenom;
          this.telephoneP = snapshot.telephone;
          this.adresseP = snapshot.adresse;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Color c3 = const Color.fromRGBO(46, 112, 206, 1.0);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Informations personnelles',
          style: TextStyle(fontSize: 25),
        ),
        backgroundColor: c3,
        centerTitle: true,
        actions: [
          Icon(
            Icons.person,
            size: 35,
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 50, right: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'VOTRE COMPTE',
              textAlign: TextAlign.center,
            ),
            Text('Votre nom : $nomP'),
            Text('Votre prenom : $prenomP'),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  decoration: TextInputDecoration.copyWith(
                      labelText: 'modifier  $emailP'),
                  onChanged: (val) {
                    if (val != null) {
                      emailP = val;
                    }
                  },
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                      color: c3),
                  child: FlatButton(
                    onPressed: () async {
                      Firestore.instance
                          .collection('patient')
                          .document(utilisateur.uid)
                          .updateData({'emailPatient': emailP});
                    },
                    child: Text(
                      'Modifier',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  decoration: TextInputDecoration.copyWith(
                      labelText: 'modifier le numéro $telephoneP'),
                  onChanged: (val) {
                    telephoneP = val;
                  },
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                      color: c3),
                  child: FlatButton(
                    onPressed: () {
                      Firestore.instance
                          .collection('patient')
                          .document(utilisateur.uid)
                          .updateData({'telephone': telephoneP});
                    },
                    child: Text(
                      'Modifier',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  decoration: TextInputDecoration.copyWith(
                      labelText: 'modifier votre $adresseP'),
                  onChanged: (val) {
                    if (val != null) {
                      adresseP = val;
                    }
                  },
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                      color: c3),
                  child: FlatButton(
                    onPressed: () {
                      Firestore.instance
                          .collection('patient')
                          .document(utilisateur.uid)
                          .updateData({'adresse': adresseP});
                    },
                    child: Text(
                      'Modifier',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            Text(
                'Ces informations sont à usage personnelles et ne sont pas\nsujette à des traitements\nVeuillez conserver judicieusement votre mot de passe '),
          ],
        ),
      ),
    );
  }
}
