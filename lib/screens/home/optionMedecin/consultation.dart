import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medecineapp/screens/home/methode_crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medecineapp/screens/home/optionMedecin/chatConsultation.dart';
import 'package:medecineapp/screens/services/database.dart';

class Consultation extends StatefulWidget {
  @override
  _ConsultationState createState() => _ConsultationState();
}

class _ConsultationState extends State<Consultation> {
  Color c3 = const Color.fromRGBO(46, 112, 206, 1.0);

  String nomM;
  String prenomM;

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser utilisateur;
  MethodeCrud crudObject = new MethodeCrud();

  QuerySnapshot users;
  QuerySnapshot chatdoc;
  //arrive à entrer dans la chat room unique et voir les messages
  //voir uniquement la liste des utilisateurs qui lui ont envoyé des messages
  void getCurrentUser() async {
    utilisateur = await _auth.currentUser();
    if (utilisateur != null) {
      GetCurrentUserData(idutilisateur: utilisateur.uid)
          .donneeUtilisateur
          .forEach((snapshot) {
        setState(() {
          this.nomM = snapshot.nom;
          this.prenomM = snapshot.prenom;
        });
      });
    }
  }

  donnee() async {
    await Firestore.instance.collection("patient").getDocuments().then((value) {
      setState(() {
        users = value;
      });
    });
    await Firestore.instance
        .collection("chatRoom")
        .getDocuments()
        .then((value) {
      setState(() {
        chatdoc = value;
      });
    });
  }

  //aller dans le chat room
  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  sendMessage(String userName) {
    List<String> users = [nomM, userName];

    String chatRoomId = getChatRoomId(nomM, userName);
    print(chatRoomId);
    print(nomM);
    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatRoomId": chatRoomId,
    };

    crudObject.addChatRoom(chatRoom, chatRoomId);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => new ChatConsultation(
                  chatRoomId: chatRoomId,
                  userName: nomM,
                )));
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    donnee();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('DEMANDE DE CONSULTATION'),
        backgroundColor: c3,
      ),
      body: Stack(
        children: [
          Container(
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
            margin: EdgeInsets.only(top: 110),
            child: userList(),
          )
        ],
      ),
    );
  }

  Widget userList() {
    if (users != null && chatdoc != null) {
      int j = chatdoc.documents.length;
      bool rep = false;
      return SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: users.documents.length,
                  padding: EdgeInsets.all(5.0),
                  itemBuilder: (context, i) {
                    for (var l = 0; l < j; l++) {
                      if (chatdoc.documents[l].documentID.contains(
                          getChatRoomId(
                              nomM, users.documents[i].data['nomPatient']))) {
                        rep = true;
                        break;
                      } else {
                        rep = false;
                      }
                    }
                    return rep
                        ? Card(
                            elevation: 10,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: c3, width: 5)),
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 25.0,
                                  backgroundColor: c3,
                                  child: Text(
                                    users.documents[i].data['nomPatient'][0]
                                        .toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 50),
                                  ),
                                ),
                                onTap: () {
                                  print(users.documents[i].data['nomPatient']);
                                  sendMessage(
                                      users.documents[i].data['nomPatient']);
                                },
                                title:
                                    Text(users.documents[i].data['nomPatient']),
                                subtitle: Text(
                                    users.documents[i].data['prenomPatient']),
                              ),
                            ),
                          )
                        : Center(
                            child: Text(" "),
                          );
                  }),
            ],
          ));
    } else {
      return Center(
        child: Text(""),
      );
    }
  }
}
