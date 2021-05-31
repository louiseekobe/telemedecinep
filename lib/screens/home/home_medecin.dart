import 'package:flutter/material.dart';
import 'package:medecineapp/screens/home/optionMedecin/agenda.dart';
import 'package:medecineapp/screens/home/optionMedecin/chatConsultation.dart';
import 'package:medecineapp/screens/home/optionMedecin/consultation.dart';
import 'package:medecineapp/screens/home/optionMedecin/groupe.dart';
import 'package:medecineapp/screens/home/optionMedecin/parametre.dart';
import 'package:medecineapp/screens/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeMedecin extends StatefulWidget {
  @override
  _HomeMedecinState createState() => _HomeMedecinState();
}

class _HomeMedecinState extends State<HomeMedecin> {
  String nomM;
  String prenomM;
  String emailM;
  String telephoneM;
  String hopitalM;
  String specialiteM;

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
      GetCurrentUserData(idutilisateur: utilisateur.uid)
          .donneeUtilisateur
          .forEach((snapshot) {
        setState(() {
          this.nomM = snapshot.nom;
          this.emailM = snapshot.email;
          this.prenomM = snapshot.prenom;
          this.telephoneM = snapshot.specialite;
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
      key: _scaffoldKey,
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
                          child: nomM != null
                              ? Text(nomM[0].toUpperCase(),
                                  style: TextStyle(color: c3, fontSize: 100))
                              : Text('D'[0].toUpperCase(),
                                  style: TextStyle(color: c3, fontSize: 100)),
                        ),
                        Text(
                          'Dr ${prenomM} \n$nomM',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Center(
                      child: Text('Que voulez-vous faire aujourd\'hui',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.meeting_room_sharp,
                color: c3,
              ),
              title: Text('CONSULTATION'),
              hoverColor: c3,
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (BuildContext context) {
                  return new Consultation();
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
              title: Text('GROUPE'),
              hoverColor: c3,
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (BuildContext context) {
                  return Groupe(
                    userName: nomM,
                  );
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
              title: Text('AGENDA'),
              hoverColor: c3,
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (BuildContext context) {
                  return Agenda();
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
                  return new Parametre();
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
                alertdialogue();
              },
            ),
            Divider(
              thickness: 3,
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
                      '$nomM $prenomM',
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
                            'CONSULTATION',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          onPressed: () {
                            Navigator.push(context, new MaterialPageRoute(
                                builder: (BuildContext context) {
                              return new Consultation();
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
                            'GROUPE',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          onPressed: () {
                            Navigator.push(context, new MaterialPageRoute(
                                builder: (BuildContext context) {
                              return Groupe(
                                userName: nomM,
                              );
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
                            'AGENDA',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          onPressed: () {
                            Navigator.push(context, new MaterialPageRoute(
                                builder: (BuildContext context) {
                              return Agenda();
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
              title: Text('$nomM'),
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
