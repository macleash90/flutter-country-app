import 'package:flutter/material.dart';

void main() {
  runApp(
    new MaterialApp(
      home: Home(),
    ),
  );
}

//class AllCountries extends StatelessWidget {
//  @override
//
//}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var title;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title = "Home";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.pink,
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          Text(title),
          RaisedButton(
            onPressed: () {
              setState(() {
                title = "About Page";
              });
            },
            child: Text('Button'),
          )
        ],
      )),
    );
  }
}
