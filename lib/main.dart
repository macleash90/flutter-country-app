

import 'package:flutter/material.dart';

void main()
{
  runApp( new MaterialApp(
    home: AllCountries() ,
  ),
  );
}

class AllCountries extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Countries All'),
        backgroundColor: Colors.pink ,
      ) ,
      body: Container(
        child: Text("Countries App"),
      ),
    )
      ;
  }
}
