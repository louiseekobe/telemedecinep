import 'package:flutter/material.dart';
import 'package:medecineapp/screens/home/optionPatient/parametre.dart';
import 'package:medecineapp/screens/home/optionPatient/dossier_medical.dart';
import 'package:medecineapp/screens/home/optionPatient/pharmacie.dart';
import 'package:medecineapp/screens/home/optionPatient/recherche_medecin.dart';
import 'package:medecineapp/screens/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePatient extends StatefulWidget {
  @override
  _HomePatientState createState() => _HomePatientState();
}

class _HomePatientState extends State<HomePatient> {
  String nomP;
  String prenomP;
  String telephoneP;
  String adresseP;
  String emailP;

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser utilisateur;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
      key: _scaffoldKey,
      // MENU COULISSANT
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              width: double.infinity,
              color: c3,
              child: Center(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 50.0,
                        backgroundColor: Colors.white,
                        child: nomP != null
                            ? Text(nomP[0].toUpperCase(),
                                style: TextStyle(color: c3, fontSize: 100))
                            : Text('P'.toUpperCase(),
                                style: TextStyle(color: c3, fontSize: 100)),
                      ),
                      Text(
                        ' ${prenomP} \n$nomP',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              )),
            ),
            ListTile(
              leading: Icon(
                Icons.meeting_room_sharp,
                color: c3,
              ),
              title: Text('RECHERCHE MEDECIN'),
              hoverColor: c3,
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (BuildContext context) {
                  return RechercheMedecin();
                }));
              },
            ),
            Divider(
              thickness: 3,
            ),
            ListTile(
              leading: Icon(
                Icons.calendar_today,
                color: c3,
              ),
              title: Text('DOSSIER MEDICAL'),
              hoverColor: c3,
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (BuildContext context) {
                  return DossierMedical();
                }));
              },
            ),
            Divider(
              thickness: 3,
            ),
            ListTile(
              leading: Icon(
                Icons.group,
                color: c3,
              ),
              title: Text('PHARMACIE'),
              hoverColor: c3,
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (BuildContext context) {
                  return Pharmacie();
                }));
              },
            ),
            Divider(
              thickness: 3,
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: c3,
              ),
              title: Text('PARAMETRE'),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (BuildContext context) {
                  return Parametre();
                }));
              },
            ),
            Divider(
              thickness: 3,
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: c3,
              ),
              title: Text('DECONNEXION'),
              onTap: () {
                //permet de se deconnecter
                alertdialogue();
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Flex(
            direction: Axis.vertical,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(70.0),
                        bottomRight: Radius.circular(70.0),
                      ),
                      color: c3),
                  child: Center(
                    child: Text(
                      '$nomP $prenomP',
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
                            'RECHERCHE MEDECIN',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          onPressed: () {
                            Navigator.push(context, new MaterialPageRoute(
                                builder: (BuildContext context) {
                              return RechercheMedecin();
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
                            'DOSSIER MEDICAL',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          onPressed: () {
                            Navigator.push(context, new MaterialPageRoute(
                                builder: (BuildContext context) {
                              return DossierMedical();
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
                            'PHARMACIE',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          onPressed: () {
                            Navigator.push(context, new MaterialPageRoute(
                                builder: (BuildContext context) {
                              return new Pharmacie();
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
                            'PARAMETRE',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          onPressed: () {
                            Navigator.push(context, new MaterialPageRoute(
                                builder: (BuildContext context) {
                              return new Parametre();
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
            top: 10,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.menu),
              color: Colors.white,
              onPressed: () {
                _scaffoldKey.currentState.openDrawer();
              },
            ),
          ),
          Positioned(
            top: 175,
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
              right: 10,
              child: GestureDetector(
                onTap: () {
                  alertdialogue();
                },
                child: Text(
                  'DECONNEXION',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ))
        ],
      ),
    );
  }

  Future<Null> alertdialogue() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: new AlertDialog(
              title: Text('$nomP'),
              content: Text('voulez-vous vous déconnecter ?'),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () async {
                      await _auth.signOut();
                      Navigator.pop(context);
                    },
                    child: Text('Déconnexion')),
                new FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('annuler'))
              ],
            ),
          );
        });
  }
}
