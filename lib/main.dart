import "package:flutter/material.dart";
import 'package:flutter_country_house/Screens/AllCountries.dart';
import 'package:flutter_country_house/Screens/CountryMap.dart';
import 'package:flutter_country_house/Screens/Country.dart';

void main() {
  runApp(
    new MaterialApp(
      home: new AllCountries(),
      routes: {
        CountryMap.routeName: (ctx) => CountryMap(),
        Country.routeName: (ctx) => Country(),
      },
    ),
  );
}
