import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medecineapp/shared/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AjoutInformtion extends StatefulWidget {
  @override
  _AjoutInformtionState createState() => _AjoutInformtionState();
}

class _AjoutInformtionState extends State<AjoutInformtion> {
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
        title: Text('Complèter votre dossier medical'),
        centerTitle: true,
        backgroundColor: c3,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 20,
              ),
              //maladies héréditaires
              TextField(
                decoration: TextInputDecoration.copyWith(
                    labelText:
                        'souffrez-vous d\'une ou des maladies \nhéréditaires mettre , entre les maladies'),
                onChanged: (val) {
                  if (val.isEmpty) {
                    maladieH = 'aucun';
                  } else {
                    maladieH = val;
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              //prescription pour maladie héréditaire
              TextField(
                decoration: TextInputDecoration.copyWith(
                    labelText:
                        'Quels médicaments prenez vous \npour vos maladies héréditaires'),
                onChanged: (val) {
                  if (val.isEmpty) {
                    prescriptionH = 'aucun';
                  } else {
                    prescriptionH = val;
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              //maladies chroniques
              TextField(
                decoration: TextInputDecoration.copyWith(
                    labelText:
                        'souffrez-vous d\'une ou des maladies \nchroniques mettre , entre les maladies'),
                onChanged: (val) {
                  if (val.isEmpty) {
                    maladieC = 'aucun';
                  } else {
                    maladieC = val;
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              //prescription maladies chronique
              TextField(
                decoration: TextInputDecoration.copyWith(
                    labelText:
                        'Quels médicaments prenez vous \npour vos maladies héréditaires'),
                onChanged: (val) {
                  if (val.isEmpty) {
                    prescriptionC = 'aucun';
                  } else {
                    prescriptionC = val;
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              //nombres d'opérations chirugicales
              TextField(
                decoration: TextInputDecoration.copyWith(
                    labelText:
                        'Donnez le nombre d\'opérations chirugicales \nque vous avez subi'),
                onChanged: (val) {
                  if (val.isEmpty) {
                    nombreOperation = 'aucun';
                  } else {
                    nombreOperation = val;
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              //préciser les opérations
              TextField(
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 10,
                decoration: TextInputDecoration.copyWith(
                    labelText:
                        'précisez le nom de l\'opération la date et le lieu \nde l\'intervention'),
                onChanged: (val) {
                  if (val.isEmpty) {
                    titreOperation = 'aucun';
                  } else {
                    titreOperation = val;
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              //groupe sanguin
              TextField(
                decoration: TextInputDecoration.copyWith(
                    labelText: 'Quel est votre groupe sanguin'),
                onChanged: (val) {
                  if (val.isEmpty) {
                    groupeSanguin = 'aucun';
                  } else {
                    groupeSanguin = val;
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              //allergie
              TextField(
                decoration: TextInputDecoration.copyWith(
                    labelText:
                        'Préciser vos allergies séparer de virgules\s\'il y a plusieurs'),
                onChanged: (val) {
                  if (val.isEmpty) {
                    allergie = 'aucun';
                  } else {
                    allergie = val;
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              //prescription pour allergies
              TextField(
                decoration: TextInputDecoration.copyWith(
                    labelText:
                        'Quels médicament prenez-vous\npour vos allergies'),
                onChanged: (val) {
                  if (val.isEmpty) {
                    prescriptionA = 'aucun';
                  } else {
                    prescriptionA = val;
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              //nom du medecin traitant
              TextField(
                decoration: TextInputDecoration.copyWith(
                    labelText: 'Quel est le nom de votre médecin traitant'),
                onChanged: (val) {
                  if (val.isEmpty) {
                    medecinTraitant = 'aucun';
                  } else {
                    medecinTraitant = val;
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              //Bouton pour envoyer les informations

              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                    color: c3),
                child: FlatButton(
                  onPressed: () {
                    alert2();
                  },
                  child: Text(
                    'VALIDER',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> alert2() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('CREER VOTRE DOSSIER MEDICAL'),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () async {
                    Firestore.instance
                        .collection('patient')
                        .document(utilisateur.uid)
                        .collection('dossierMedical')
                        .document(utilisateur.uid + 'dossierMedical')
                        .setData({
                      'maladieHereditaire': maladieH,
                      'prescriptionHereditaire': prescriptionH,
                      'maladieChronique': maladieC,
                      'prescriptionChronique': prescriptionC,
                      'operation': titreOperation,
                      'nombreOperation': nombreOperation,
                      'groupeSanguin': groupeSanguin,
                      'allergie': allergie,
                      'prescriptionAllergie': prescriptionA,
                      'medecinTraitant': medecinTraitant
                    }).catchError((e) {
                      print(e);
                    });
                    print(utilisateur.uid);
                    Navigator.pop(context);
                  },
                  child: Text('ENVOYER')),
              new FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('ANNULER'))
            ],
          );
        });
  }
}
