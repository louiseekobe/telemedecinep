import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medecineapp/models/datauser.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //represente les references de nos collection dans le firestore
  //instance de firestore qui est une collection qu'on va appeler Patient
  final CollectionReference patientCollection =
      Firestore.instance.collection('Patient');

  //represente les references de nos collection dans le firestore
  //instance de firestore qui est une collection qu'on va appeler Medecin
  final CollectionReference medecinCollection =
      Firestore.instance.collection('Medecin');
}

class GetCurrentUserData {
  String idutilisateur;

  GetCurrentUserData({this.idutilisateur});

  //la reference de la collection de l'utilisateur
  final CollectionReference collectionUtilisateur =
      Firestore.instance.collection('medecin');

  //recupere données instantané de l'utilisateur
  DataMedecin _dataUserSnapshot(DocumentSnapshot snapshot) {
    return DataMedecin(
      nom: snapshot['nomMedecin'],
      prenom: snapshot['prenomMedecin'],
      email: snapshot['emailMedecin'],
      telephone: snapshot['telephone'],
      hopital: snapshot['hopital'],
      specialite: snapshot['specialite'],
    );
  }

//optenir les données de l'utilisateur par stream
//les données sont capturées par la fonction _dataUserSnapshit
  Stream<DataMedecin> get donneeUtilisateur {
    return collectionUtilisateur
        .document(idutilisateur)
        .snapshots()
        .map(_dataUserSnapshot);
  }
}

class GetCurrentUserDataP {
  String idutilisateur;

  GetCurrentUserDataP({this.idutilisateur});

  //la reference de la collection de l'utilisateur
  final CollectionReference collectionUtilisateur =
      Firestore.instance.collection('patient');

  //recupere données instantané de l'utilisateur
  DataPatient _dataUserSnapshot(DocumentSnapshot snapshot) {
    return DataPatient(
        nom: snapshot.data['nomPatient'],
        prenom: snapshot.data['prenomPatient'],
        email: snapshot.data['emailPatient'],
        telephone: snapshot.data['telephone'],
        adresse: snapshot.data['adresse']);
  }

//optenir les données de l'utilisateur par stream
//les données sont capturées par la fonction _dataUserSnapshit
  Stream<DataPatient> get donneeUtilisateur {
    return collectionUtilisateur
        .document(idutilisateur)
        .snapshots()
        .map(_dataUserSnapshot);
  }
}

class GetCurrentUserDataDossier {
  String id;
  GetCurrentUserDataDossier({this.id});

  CollectionReference collectionReference(id) {
    return Firestore.instance
        .collection('patient')
        .document(id)
        .collection('dossierMedical');
  }

  //recupere données instantané de l'utilisateur
  DataDossier _dataUserSnapshot(DocumentSnapshot snapshot) {
    return DataDossier(
      maladieH: snapshot.data['maladieHereditaire'],
      prescriptionH: snapshot.data['prescriptionHereditaire'],
      maladieC: snapshot.data['maladieChronique'],
      prescriptionC: snapshot.data['prescriptionChronique'],
      titreOperation: snapshot.data['operation'],
      nombreOperation: snapshot.data['nombreOperation'],
      groupeSanguin: snapshot.data['groupeSanguin'],
      allergie: snapshot.data['allergie'],
      prescriptionA: snapshot.data['prescriptionAllergie'],
      medecinTraitant: snapshot.data['medecinTraitant'],
    );
  }

  //optenir les données de l'utilisateur par stream
//les données sont capturées par la fonction _dataUserSnapshit
  Stream<DataDossier> get donneeUtilisateur {
    return collectionReference(id)
        .document(id + 'dossierMedical')
        .snapshots()
        .map(_dataUserSnapshot);
  }
}
