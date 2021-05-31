import 'package:flutter/material.dart';
import 'package:medecineapp/screens/home/home_patient.dart';
import 'package:medecineapp/screens/home/optionPatient/afficher_dossier.dart';
import 'package:medecineapp/screens/home/optionPatient/ajout_information.dart';

class DossierMedical extends StatefulWidget {
  @override
  _DossierMedicalState createState() => _DossierMedicalState();
}

class _DossierMedicalState extends State<DossierMedical> {
  Color c3 = const Color.fromRGBO(46, 112, 206, 1.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(70.0),
                      bottomRight: Radius.circular(70.0),
                    ),
                    color: c3),
                child: Center(
                  child: Text(
                    'DOSSIER MEDICAL',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 50, right: 50, top: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 70,
                      child: RaisedButton(
                        elevation: 10.0,
                        color: c3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        hoverColor: Colors.blueAccent,
                        child: Text(
                          'AJOUTER UNE INFORMATION',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (BuildContext context) {
                            return new AjoutInformtion();
                          }));
                        },
                      ),
                    ),
                    Container(
                      height: 70,
                      child: RaisedButton(
                        elevation: 10.0,
                        color: c3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        hoverColor: Colors.blueAccent,
                        child: Text(
                          'VOIR VOTRE DOSSIER',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (BuildContext context) {
                            return AfficherDossier();
                          }));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: 300,
          right: 50,
          left: 50,
          child: Container(
            height: 100,
            width: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(70.0)),
                color: Colors.white,
                border: Border.all(width: 3, color: c3)),
            child: Center(
              child: Text(
                'Que fait-on ?',
                style: TextStyle(
                    color: c3, fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Positioned(
            top: 30,
            left: 10,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (BuildContext context) {
                  return HomePatient();
                }));
              },
              child: Text('RETOUR',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ))
      ]),
    );
  }
}
