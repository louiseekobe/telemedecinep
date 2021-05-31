import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medecineapp/screens/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medecineapp/shared/constant.dart';

class Parametre extends StatefulWidget {
  @override
  _ParametreState createState() => _ParametreState();
}

class _ParametreState extends State<Parametre> {
  String nomM;
  String prenomM;
  String emailM;
  String telephoneM;
  String hopitalM;
  String specialiteM;

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
      GetCurrentUserData(idutilisateur: utilisateur.uid)
          .donneeUtilisateur
          .forEach((snapshot) {
        setState(() {
          this.nomM = snapshot.nom;
          this.emailM = snapshot.email;
          this.prenomM = snapshot.prenom;
          this.telephoneM = snapshot.telephone;
          this.hopitalM = snapshot.hopital;
          this.specialiteM = snapshot.specialite;
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
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
        backgroundColor: c3,
        centerTitle: true,
        actions: [Icon(Icons.person, size: 35, color: Colors.white)],
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
            Text('Votre nom : $nomM'),
            Text('Votre prenom : $prenomM'),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  decoration: TextInputDecoration.copyWith(
                      labelText: 'modifier  $emailM'),
                  onChanged: (val) {
                    if (val != null) {
                      emailM = val;
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
                          .collection('medecin')
                          .document(utilisateur.uid)
                          .updateData({'emailMedecin': emailM});
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
                      labelText: 'modifier le numéro $telephoneM'),
                  onChanged: (val) {
                    telephoneM = val;
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
                          .collection('medecin')
                          .document(utilisateur.uid)
                          .updateData({'telephone': telephoneM});
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
            Text('Votre specialite : $specialiteM'),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  decoration: TextInputDecoration.copyWith(
                      labelText: 'modifier le lieu de service $hopitalM'),
                  onChanged: (val) {
                    if (val != null) {
                      hopitalM = val;
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
                          .collection('medecin')
                          .document(utilisateur.uid)
                          .updateData({'hopital': hopitalM});
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
