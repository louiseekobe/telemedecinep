import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medecineapp/screens/home/home_patient.dart';
import 'package:medecineapp/screens/home/methode_crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medecineapp/screens/services/database.dart';
import 'package:medecineapp/screens/home/optionPatient/chat.dart';

class RechercheMedecin extends StatefulWidget {
  @override
  _RechercheMedecinState createState() => _RechercheMedecinState();
}

class _RechercheMedecinState extends State<RechercheMedecin> {
  Color c3 = const Color.fromRGBO(46, 112, 206, 1.0);
  TextEditingController search = new TextEditingController();

  String nomP;
  String emailP;

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser utilisateur;
  MethodeCrud crudObject = new MethodeCrud();
  QuerySnapshot users;
  QuerySnapshot users2;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    GetCurrentUserDataP();
    crudObject.renvoyerDonneeMedecin().then((results) {
      setState(() {
        users = results;
      });
    });
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
        });
      });
    }
  }

  void searchMethode() {
    crudObject.searchByName(search.text).then((results) {
      setState(() {
        users2 = results;
      });
    });
  }

  //create methode for send message
  /// 1.create a chatroom, send user to the chatroom, other userdetails
  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  sendMessage(String userName, String idM) {
    List<String> users = [nomP, userName];

    String chatRoomId = getChatRoomId(nomP, userName);

    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatRoomId": chatRoomId,
    };

    crudObject.addChatRoom(chatRoom, chatRoomId);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Chat(
                  chatRoomId: chatRoomId,
                  nameUser: nomP,
                  idMedecin: idM,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //afficher tous les elements contenus dans la collection
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 0),
            height: 80,
            width: MediaQuery.of(context).size.width,
            color: c3,
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                GestureDetector(
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
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                ),
                Text("LISTE MEDECINS",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            margin: EdgeInsets.only(top: 80),
            height: 100,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: search,
                    decoration: InputDecoration(
                      hintText: "recherche medecin",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: c3, width: 3.0),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (search.text.isNotEmpty) {
                      searchMethode();
                    } else {
                      setState(() {
                        users2 = null;
                      });
                    }
                  },
                  child: Icon(
                    Icons.search,
                    color: c3,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 190),
            height: 100,
            color: Colors.white,
            child: Center(
              child: Text(
                "LES PRIX DES CONSULTATIONS :\nGénéralistes : 500 francs CFA\nSpécialiste : 1000 francs CFA",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 290),
            color: Colors.white,
            child: userList(),
          )
        ],
      ),
    );
  }

  //afficher soit la liste des recherches soit la liste des utilisateurs
  //envoyer ces utilisateur dans un chat room

  Widget userList() {
    if (users2 != null) {
      return SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: <Widget>[
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: users2.documents.length,
              padding: EdgeInsets.all(5.0),
              itemBuilder: (context, i) {
                return Card(
                  elevation: 10,
                  child: Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: c3, width: 5)),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 50.0,
                        backgroundColor: c3,
                        child: Text(
                          users2.documents[i].data['nomMedecin'][0]
                              .toUpperCase(),
                          style: TextStyle(color: Colors.white, fontSize: 50),
                        ),
                      ),
                      onTap: () {
                        sendMessage(users2.documents[i].data['nomMedecin'],
                            users2.documents[i].data['idMedecin']);
                      },
                      title: Text(
                          'NOM : ' + users2.documents[i].data['nomMedecin'],
                          style: TextStyle(fontSize: 20)),
                      subtitle: Text(
                        'PRENOM : ' +
                            users2.documents[i].data['prenomMedecin'] +
                            '\nSPECIALITE : ' +
                            users2.documents[i].data['specialite'] +
                            '\nNOTATION : ' +
                            users2.documents[i].data['notation'].toString(),
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    } else if (users != null) {
      return SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: <Widget>[
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: users.documents.length,
              padding: EdgeInsets.all(5.0),
              itemBuilder: (context, i) {
                return Card(
                  elevation: 10,
                  child: Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: c3, width: 5)),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 50.0,
                        backgroundColor: c3,
                        child: Text(
                          users.documents[i].data['nomMedecin'][0]
                              .toUpperCase(),
                          style: TextStyle(color: Colors.white, fontSize: 50),
                        ),
                      ),
                      onTap: () {
                        sendMessage(users.documents[i].data['nomMedecin'],
                            users.documents[i].data['idMedecin']);
                      },
                      title: Text(
                          'NOM : ' + users.documents[i].data['nomMedecin'],
                          style: TextStyle(fontSize: 20)),
                      subtitle: Text(
                        'PRENOM : ' +
                            users.documents[i].data['prenomMedecin'] +
                            '\nSPECIALITE : ' +
                            users.documents[i].data['specialite'] +
                            '\nNOTATION : ' +
                            users.documents[i].data['notation'].toString(),
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    } else {
      return Center(
        child: Text(' '),
      );
    }
  }
}
