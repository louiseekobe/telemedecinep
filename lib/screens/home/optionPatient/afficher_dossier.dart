import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medecineapp/screens/services/database.dart';

class AfficherDossier extends StatefulWidget {
  @override
  _AfficherDossierState createState() => _AfficherDossierState();
}

class _AfficherDossierState extends State<AfficherDossier> {
  Color c3 = const Color.fromRGBO(46, 112, 206, 1.0);

  //variable du sous menu du dossier médical
  String maladieH = '';
  String prescriptionH = '';
  String maladieC = '';
  String prescriptionC = '';
  String titreOperation = '';
  String nombreOperation = '';
  String groupeSanguin = '';
  String allergie = '';
  String prescriptionA = '';
  String medecinTraitant = '';

  //variables de firebase
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser utilisateur;

  void getCurrentUser() async {
    utilisateur = await _auth.currentUser();

    if (utilisateur != null) {
      GetCurrentUserDataDossier(id: utilisateur.uid)
          .donneeUtilisateur
          .forEach((snapshot) {
        setState(() {
          this.maladieH = snapshot.maladieH;
          this.prescriptionH = snapshot.prescriptionH;
          this.maladieC = snapshot.maladieC;
          this.prescriptionC = snapshot.prescriptionC;
          this.titreOperation = snapshot.titreOperation;
          this.nombreOperation = snapshot.nombreOperation;
          this.groupeSanguin = snapshot.groupeSanguin;
          this.allergie = snapshot.allergie;
          this.prescriptionA = snapshot.prescriptionA;
          this.medecinTraitant = snapshot.medecinTraitant;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Votre Dossier Médical'),
        centerTitle: true,
        backgroundColor: c3,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //maladie hereditaire
              Card(
                elevation: 5,
                child: Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: c3, width: 5)),
                  height: 200,
                  child: Center(
                    child: Text(
                      'MALADIES : \n\nMaladies Héréditaires : \n$maladieH\n\nMaladies Chroniques : \n$maladieC\n\nAllergies : \n$allergie',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              //prescription
              Card(
                elevation: 5,
                child: Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: c3, width: 5)),
                  height: 200,
                  child: Center(
                    child: Text(
                      'PRESCRIPTIONS : \n\nMédicament pour maladies  héréditaires : \n$prescriptionH\n\nMédicament pour maladies chroniques : \n$prescriptionC\n\nMédicament pour les allergies : \n$prescriptionA',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              //operations
              Card(
                elevation: 5,
                child: Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: c3, width: 5)),
                  height: 150,
                  child: Center(
                    child: Text(
                      'OPERATIONS : \n\nIntitulés opérations : \n$titreOperation\n\nNombres opérations : \n$nombreOperation',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              //medecin traitant
              Card(
                elevation: 5,
                child: Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: c3, width: 5)),
                  height: 150,
                  child: Center(
                    child: Text(
                      'MEDECIN TRAITANT : \n\nNom du medecin traitant : \n$medecinTraitant',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
