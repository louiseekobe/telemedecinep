import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MethodeCrud {
  bool estConnecte() {
    return (FirebaseAuth.instance.currentUser != null) ? true : false;
  }

  Future<void> ajoutDonnePatient(data) async {
    if (estConnecte()) {
      Firestore.instance.collection('patient').add(data).catchError((e) {
        print(e);
      });
    } else {
      print('besoin de connexion');
    }
  }

  renvoyerDonneePatient() async {
    return Firestore.instance.collection("patient").getDocuments();
  }

  renvoyerDonneeMedecin() async {
    return Firestore.instance
        .collection('medecin')
        .orderBy("notation", descending: true)
        .getDocuments();
  }

  renvoyerDonneePharmacie() async {
    return Firestore.instance.collection('pharmacie').getDocuments();
  }

  updateDonneePatient(selectDoc, newData) async {
    return Firestore.instance
        .collection('patient')
        .document(selectDoc)
        .updateData(newData)
        .catchError((e) {
      print(e);
    });
  }

  updateDonneeMedecin(selectDoc, newData) async {
    return Firestore.instance
        .collection('medecin')
        .document(selectDoc)
        .updateData(newData)
        .catchError((e) {
      print(e);
    });
  }

  //fonction de recherches
  getUserInfo(String email) async {
    return Firestore.instance
        .collection("medecin")
        .where("emailMedecin", isEqualTo: email)
        .getDocuments()
        .catchError((e) {
      print(e.toString());
    });
  }

  searchByName(String searchField) {
    return Firestore.instance
        .collection("medecin")
        .where('nomMedecin', isEqualTo: searchField)
        .getDocuments();
  }

  searchByAdresse(String searchField) {
    return Firestore.instance
        .collection("pharmacie")
        .where("quartier", isEqualTo: searchField)
        .getDocuments();
  }

  //renvoyer les information du chatroom
  renvoyerDonneeChat() async {
    return Firestore.instance.collection("chatRoom").getDocuments();
  }

  //fonctions chat
  Future<bool> addChatRoom(chatRoom, chatRoomId) {
    Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .setData(chatRoom)
        .catchError((e) {
      print(e);
    });
  }

  getChats(String chatRoomId) async {
    return Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }

  Future<void> addMessage(String chatRoomId, chatMessageData) {
    Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .add(chatMessageData)
        .catchError((e) {
      print(e.toString());
    });
  }

  getUserChats(String itIsMyName) async {
    return await Firestore.instance
        .collection("chatRoom")
        .where('users', arrayContains: itIsMyName)
        .snapshots();
  }

  //fontion groupe
  Future<bool> addGroupRoom(chatRoom) {
    Firestore.instance
        .collection("chatRoom")
        .document("groupRoom")
        .setData(chatRoom)
        .catchError((e) {
      print(e);
    });
  }

  getgroupChats() async {
    return Firestore.instance
        .collection("groupRoom")
        .document("groupe")
        .collection("groupe")
        .orderBy('time')
        .snapshots();
  }

  Future<void> addGroupMessage(chatMessageData) {
    Firestore.instance
        .collection("chatRoom")
        .document("groupRoom")
        .collection("groupe")
        .add(chatMessageData)
        .catchError((e) {
      print(e.toString());
    });
  }

  getMessageChats() async {
    return await Firestore.instance
        .collection("chatRoom")
        .document("groupRoom")
        .collection("groupe")
        .orderBy('time')
        .snapshots();
  }
}
