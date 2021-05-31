import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medecineapp/screens/home/methode_crud.dart';

class Pharmacie extends StatefulWidget {
  @override
  _PharmacieState createState() => _PharmacieState();
}

class _PharmacieState extends State<Pharmacie> {
  Color c3 = const Color.fromRGBO(46, 112, 206, 1.0);
  TextEditingController search = new TextEditingController();

  MethodeCrud crudObject = new MethodeCrud();
  QuerySnapshot listPharmacie;
  QuerySnapshot listPharmacieResearch;

  @override
  void initState() {
    super.initState();
    crudObject.renvoyerDonneePharmacie().then((results) {
      setState(() {
        listPharmacie = results;
      });
    });
  }

  void searchPharmacie(adresse) {
    crudObject.searchByAdresse(adresse).then((result) {
      setState(() {
        listPharmacieResearch = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //Color c3 = const Color.fromRGBO(110, 209, 224, 1.0);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('LISTE DES PHARMACIES'),
        backgroundColor: c3,
        centerTitle: true,
      ),
      body: Container(
        child: Stack(
          children: [
            Container(
                margin: EdgeInsets.only(top: 100),
                color: Colors.white,
                child: pharmacieList()),
            Container(
              height: 100,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: search,
                      decoration: InputDecoration(
                        hintText: "recherche par quartier",
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
                        print(search.text);
                        searchPharmacie(search.text);
                      } else {
                        setState(() {
                          listPharmacieResearch = null;
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
          ],
        ),
      ),
    );
  }

  //widget pour afficher la liste des pharmacies
  Widget pharmacieList() {
    if (listPharmacieResearch != null) {
      return SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: <Widget>[
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: listPharmacieResearch.documents.length,
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
                          listPharmacieResearch.documents[i].data['nom'][0]
                              .toUpperCase(),
                          style: TextStyle(color: Colors.white, fontSize: 50),
                        ),
                      ),
                      title: Text(
                          'PHARMACIE ' +
                              listPharmacieResearch.documents[i].data['nom'],
                          style: TextStyle(fontSize: 20)),
                      subtitle: Text(
                        'Adresse : ' +
                            listPharmacieResearch.documents[i].data['adresse'] +
                            '\nNuméro de téléphone : ' +
                            listPharmacieResearch
                                .documents[i].data['telephone'] +
                            '\nQuartier : ' +
                            listPharmacieResearch.documents[i].data['quartier'],
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
    } else if (listPharmacie != null) {
      return SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: <Widget>[
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: listPharmacie.documents.length,
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
                          listPharmacie.documents[i].data['nom'][0]
                              .toUpperCase(),
                          style: TextStyle(color: Colors.white, fontSize: 50),
                        ),
                      ),
                      title: Text(
                          'PHARMACIE ' + listPharmacie.documents[i].data['nom'],
                          style: TextStyle(fontSize: 20)),
                      subtitle: Text(
                        'Adresse : ' +
                            listPharmacie.documents[i].data['adresse'] +
                            '\nNuméro de téléphone : ' +
                            listPharmacie.documents[i].data['telephone'] +
                            '\nQuartier : ' +
                            listPharmacie.documents[i].data['quartier'],
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
