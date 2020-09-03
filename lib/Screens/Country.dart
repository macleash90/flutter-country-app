import 'package:flutter/material.dart';

class Country extends StatelessWidget {
  final String name;
  Country(this.name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.pink,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Card(
          elevation: 10,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(name),
          ),
        ),
      ),
    );
  }
}
