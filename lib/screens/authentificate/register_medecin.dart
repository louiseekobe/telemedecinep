import 'package:flutter/material.dart';
import 'package:medecineapp/shared/constant.dart';
import 'package:medecineapp/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterMedecin extends StatefulWidget {
  //creer une variable de type function
  final Function toggleView;
  //initialiser le constructeur de la classe avec cette fonction
  RegisterMedecin({this.toggleView});
  @override
  _RegisterMedecinState createState() => _RegisterMedecinState();
}

class _RegisterMedecinState extends State<RegisterMedecin> {
  //instance de la firebase
  FirebaseAuth _auth2 = FirebaseAuth.instance;
  FirebaseUser currentUser;

  //collection utilisateur depuis firestore
  final CollectionReference collectionUtil =
      Firestore.instance.collection('medecin');

  //on va créer une variable de type privé pour notre formulaire
  final _formkey = GlobalKey<FormState>();

  bool loading = false;

  //text field state
  String nom = '';
  String prenom = '';
  String telephone = '';
  String specialite = '';
  String hopital = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    Color c3 = const Color.fromRGBO(46, 112, 206, 1.0);
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.blueGrey[90],
            body: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: 200,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'INSCRIPTION\nMEDECIN',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 40.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(70.0),
                        bottomRight: Radius.circular(70.0),
                      ),
                      color: c3),
                ),
                Container(
                  height: 200,
                  width: 200,
                  child: Image.asset(
                    'img/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                  child: Form(
                    //Associer le formulaire a la cle globla pour pouvoir valider notre formulaire
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                          height: 20.0,
                        ),
                        //pour saisir le nom
                        TextFormField(
                          decoration: TextInputDecoration.copyWith(
                              labelText: 'entrer votre nom'),
                          validator: (val) =>
                              val.isEmpty ? 'Entrer votre nom' : null,
                          onChanged: (val) {
                            setState(() => nom = val);
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        //pour saisir l'email
                        TextFormField(
                          decoration: TextInputDecoration.copyWith(
                              labelText: 'entrer votre prenom'),
                          validator: (val) =>
                              val.isEmpty ? 'Entrer votre prenom' : null,
                          onChanged: (val) {
                            setState(() => prenom = val);
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        //pour saisir le telephone
                        TextFormField(
                          decoration: TextInputDecoration.copyWith(
                              labelText: 'entrer votre numéro de telephone'),
                          validator: (val) => val.isEmpty
                              ? 'Entrer votre numéro de téléphone'
                              : null,
                          onChanged: (val) {
                            setState(() => telephone = val);
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        //pour saisir la spécialité
                        TextFormField(
                          decoration: TextInputDecoration.copyWith(
                              labelText: 'entrer votre spécialite'),
                          validator: (val) =>
                              val.isEmpty ? 'Entrer votre spécialité' : null,
                          onChanged: (val) {
                            setState(() => specialite = val);
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        //pour saisir l'email
                        TextFormField(
                          decoration: TextInputDecoration.copyWith(
                              labelText:
                                  'entrer le lieu de service : Aucun pour rien'),
                          //propriété de la fonction valide pour definir si le formulaire est valide
                          validator: (val) => val.isEmpty
                              ? 'Entrer lieu de service : Aucun pour rien'
                              : null,
                          onChanged: (val) {
                            setState(() => hopital = val);
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        //pour saisir l'email
                        TextFormField(
                          decoration:
                              TextInputDecoration.copyWith(labelText: 'email'),
                          //propriété de la fonction valide pour definir si le formulaire est valide
                          validator: (val) =>
                              val.isEmpty ? 'Entrer votre email' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        //pour sasir le mot de passe
                        TextFormField(
                          decoration: TextInputDecoration.copyWith(
                              labelText: 'mot de passe'),
                          obscureText: true,
                          validator: (val) => val.length < 6
                              ? 'Entrer un mot de passe de plus de 6 caracteres'
                              : null,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          decoration: TextInputDecoration.copyWith(
                              labelText: 'confirmer le mot de passe'),
                          obscureText: true,
                          validator: (val) => password != confirmPassword
                              ? 'le mot de passe est different'
                              : null,
                          onChanged: (val) {
                            setState(() => confirmPassword = val);
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        //POUR POUVOIR S'ENREGISTRER
                        RaisedButton(
                          color: c3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          hoverColor: Colors.blueAccent,
                          child: Text(
                            'S\'INSCRIRE',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () async {
                            if (_formkey.currentState.validate()) {
                              setState(() => loading = true);
                              AuthResult result =
                                  await _auth2.createUserWithEmailAndPassword(
                                      email: email,
                                      password: password); //creer un user
                              currentUser = result.user;
                              //on va charger les information du medecin
                              await collectionUtil
                                  .document(currentUser.uid)
                                  .setData({
                                'idMedecin': currentUser.uid,
                                'nomMedecin': nom,
                                'prenomMedecin': prenom,
                                'telephone': telephone,
                                'specialite': specialite,
                                'hopital': hopital,
                                'emailMedecin': email,
                                'notation': 0
                              });
                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  error =
                                      'Essater encore mot de passe ou email invalide';
                                });
                              }
                            }
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        //POUR ALLER DANS LA PAGE SE CONNECTER
                        OutlineButton(
                          onPressed: () {
                            widget.toggleView();
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          borderSide: BorderSide(width: 2.0, color: c3),
                          hoverColor: Colors.blueAccent,
                          child: Text(
                            'vous avez déjà un compte',
                            style: TextStyle(color: c3, fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          error,
                          style: TextStyle(
                              color: Colors.red, fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
          );
  }
}
