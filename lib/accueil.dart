import 'package:flutter/material.dart';
import 'package:medecineapp/models/user.dart';
import 'package:medecineapp/screens/services/auth.dart';
import 'package:medecineapp/screens/medecin.dart';
import 'package:medecineapp/screens/patient.dart';
import 'package:provider/provider.dart';

class Accueil extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _Accueil();
  }
}

class _Accueil extends State<Accueil> {
  Color c3 = const Color.fromRGBO(46, 112, 206, 1.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
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
                      'KAAY FAJUU\nRENCONTRE VOTRE MEDECIN\nDANS SON ANDROID',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
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
                        height: 150,
                        width: 150,
                        child: Image.asset(
                          'img/logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      Center(
                        child: Text(
                          'VOUS ETES :',
                          style: TextStyle(
                              color: c3,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
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
                            'MEDECIN',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          onPressed: () {
                            //Permet d'aller dans la page medecin en fonction de la connexion
                            Navigator.push(context, new MaterialPageRoute(
                                builder: (BuildContext context) {
                              return StreamProvider<User>.value(
                                value: AuthServices().user,
                                child: MaterialApp(
                                  debugShowCheckedModeBanner: false,
                                  home: Medecin(),
                                ),
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
                            'PATIENT',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          onPressed: () {
                            //peremt d'aller dans la page patient en fonction de la connexion
                            Navigator.push(context, new MaterialPageRoute(
                                builder: (BuildContext context2) {
                              return StreamProvider<User>.value(
                                value: AuthServices().user,
                                child: MaterialApp(
                                  debugShowCheckedModeBanner: false,
                                  home: Patient(),
                                ),
                              );
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
                  'SALAM, NAKALA YARAM BI DEFF ? ?',
                  style: TextStyle(
                      color: c3, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
