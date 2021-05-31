//cette classe va nous servir de template pour la présentation des données de nos utilisateurs
class DataMedecin {
  final String nom;
  final String prenom;
  final String email;
  final String telephone;
  final String hopital;
  final String specialite;

  DataMedecin(
      {this.nom,
      this.prenom,
      this.email,
      this.telephone,
      this.hopital,
      this.specialite});
}

class DataPatient {
  final String nom;
  final String prenom;
  final String telephone;
  final String adresse;
  final String email;

  DataPatient(
      {this.nom, this.prenom, this.telephone, this.adresse, this.email});
}

class DataDossier {
  final String maladieH;
  final String prescriptionH;
  final String maladieC;
  final String prescriptionC;
  final String titreOperation;
  final String nombreOperation;
  final String groupeSanguin;
  final String allergie;
  final String prescriptionA;
  final String medecinTraitant;

  DataDossier(
      {this.maladieH,
      this.prescriptionH,
      this.maladieC,
      this.prescriptionC,
      this.titreOperation,
      this.nombreOperation,
      this.groupeSanguin,
      this.allergie,
      this.prescriptionA,
      this.medecinTraitant});
}

class Constants{

  static String myName = "";
}

