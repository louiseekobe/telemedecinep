import 'package:flutter/material.dart';

const TextInputDecoration = InputDecoration(
  //ajouter la couleur
  fillColor: Colors.white,
  filled: true, //rendre la couleur visible
  //definir la bordure de notre textFormField
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.0)),
  //ajouter la propriété focusborder lorsqu'on va saisir
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue, width: 2.0)),
);
