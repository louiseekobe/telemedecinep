import 'package:flutter/material.dart';
import 'package:medecineapp/screens/services/auth.dart';
import 'package:medecineapp/shared/constant.dart';
import 'package:medecineapp/shared/loading.dart';

class SignInMedecin extends StatefulWidget {
  //creer une variable de type function
  final Function toggleView;
  //initialiser le constructeur de la classe avec cette fonction
  SignInMedecin({this.toggleView});
  @override
  _SignInMedecinState createState() => _SignInMedecinState();
}

class _SignInMedecinState extends State<SignInMedecin> {
  //instance de la classe Authservices pour pouvoir utiliser ces methodes
  final AuthServices _auth = AuthServices();

  //on va créer une variable de type privé pour notre formulaire
  final _formkey = GlobalKey<FormState>();
  final _formkey2 = GlobalKey<FormState>();

  //creer une variable pour afficher notre loading
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    //afficher le reset mot de passe
    void _showSettingsPanel() {
      String mail = '';
      Color c3 = const Color.fromRGBO(46, 112, 206, 1.0);
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.all(50),
              child: Form(
                key: _formkey2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Center(
                      child: Text(
                        'Saisir votre email pour reinitialiser votre mot de passe',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    TextFormField(
                      decoration:
                          TextInputDecoration.copyWith(labelText: 'email'),
                      validator: (val) =>
                          val.isEmpty ? 'Entrer votre email' : null,
                      onChanged: (val) {
                        setState(() => mail = val);
                      },
                    ),
                    RaisedButton(
                      color: c3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Text(
                        'RESET LE MOT DE PASSE',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formkey2.currentState.validate()) {
                          await _auth.reset(mail);
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          });
    }

    Color c3 = const Color.fromRGBO(46, 112, 206, 1.0);
    //si loading est true afficher le widget Loading sinon retourner le Scaffold
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.cyanAccent[90],
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 200,
                    width: double.infinity,
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'CONNEXTION\nMEDECIN',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 40.0),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )),
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
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(
                            height: 20.0,
                          ),

                          //pour saisir l'email
                          TextFormField(
                            decoration: TextInputDecoration.copyWith(
                                labelText: 'email'),
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
                          //bouton pour la connexion
                          FlatButton(
                            color: c3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            hoverColor: Colors.blueAccent,
                            child: Text(
                              'SE CONNECTER',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              if (_formkey.currentState.validate()) {
                                setState(() => loading = true);
                                dynamic result =
                                    await _auth.signInWithEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  setState(() {
                                    error = 'le mot de passe ou email invalide';
                                    loading = false;
                                  });
                                }
                              }
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          //BOUTON POUR L'INSCRIPTION
                          OutlineButton(
                            onPressed: () {
                              widget.toggleView();
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            borderSide: BorderSide(width: 2.0, color: c3),
                            hoverColor: Colors.blueAccent,
                            child: Text(
                              'S\'INSCRIRE',
                              style: TextStyle(color: c3),
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            error,
                            style: TextStyle(
                                color: Colors.red, fontStyle: FontStyle.italic),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),

                          //RESET PASSWORD
                          OutlineButton(
                            onPressed: () => _showSettingsPanel(),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            borderSide: BorderSide(width: 2.0, color: c3),
                            hoverColor: Colors.blueAccent,
                            child: Text(
                              'AVEZ_VOUS OUBLIE VOTRE MOT DE PASSE',
                              style: TextStyle(color: c3),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
