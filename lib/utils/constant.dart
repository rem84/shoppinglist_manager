import 'dart:core';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// This file contains all the routing constants used within the app

const String homeRoute = '/';
const String listarticleRoute = '/listarticle';
//const String introscreenRoute = '/introscreen';
//const String courselistRoute = '/courselist';

//enum FamilleProduit {legume, divers, gouter, boisson, sdb}

enum FamilleProduit {
  /*car(tires: 4, passengers: 5, carbonPerKilometer: 400),
  bus(tires: 6, passengers: 50, carbonPerKilometer: 800),
  bicycle(tires: 2, passengers: 1, carbonPerKilometer: 0);*/
  legume(nom : 'Légume', logo : Icon(Icons.air)),
  divers(nom : 'Divers', logo : Icon(Icons.car_crash)),
  gouter(nom : 'Goûter', logo : Icon(Icons.book)),
  boisson(nom : 'Boisson', logo : Icon(Icons.do_not_touch)),
  animal(nom : 'Animaux', logo : Icon(Icons.apple));

  final String nom;
  final Icon? logo;

  const FamilleProduit({required this.nom, this.logo});

  /*int get carbonFootprint => (carbonPerKilometer / passengers).round();

  bool get isTwoWheeled => this == Vehicle.bicycle;

  @override
  int compareTo(Vehicle other) => carbonFootprint - other.carbonFootprint;*/
}

String formatDate(DateTime ?date){
  if(date == null){
   return '';
  }
  else {
    return DateFormat('dd/MM/yyyy').format(date);
  }
}