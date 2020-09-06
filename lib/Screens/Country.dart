import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_country_house/Screens/CountryMap.dart';

class Country extends StatelessWidget {
//  final Map country;
  static const routeName = '/country';
//  Country(this.country);

//  void getCountryData() {}
  @override
  Widget build(BuildContext context) {
    final Map country = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(country['name']),
        backgroundColor: Colors.pink,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: GridView(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          children: [
            FlipCard(
              direction: FlipDirection.VERTICAL, // default
              front: Container(
                child: CountryCard('Capital'),
              ),
              back: Container(
                child: CountryDetailCard(
                    title: country['capital'], the_color: Colors.deepOrange),
              ),
            ),
            FlipCard(
              direction: FlipDirection.HORIZONTAL, // default
              front: Container(
                child: CountryCard('Population'),
              ),
              back: Container(
                child: CountryDetailCard(
                    title: country['population'].toString(),
                    the_color: Colors.blue),
              ),
            ),
            FlipCard(
              direction: FlipDirection.HORIZONTAL, // default
              front: Container(
                child: CountryCard('Flag'),
              ),
              back: Container(
                child: SvgPicture.network(
                  country['flag'],
                  width: 200,
                  semanticsLabel: country['name'],
                  placeholderBuilder: (BuildContext context) => Container(
                      padding: const EdgeInsets.all(30.0),
                      child: const CircularProgressIndicator()),
                ),
              ),
            ),
            FlipCard(
              direction: FlipDirection.HORIZONTAL, // default
              front: Container(
                child: CountryCard('Currency'),
              ),
              back: Container(
                child: CountryDetailCard(
                    title: country['currencies'][0]['name'],
                    the_color: Colors.pink),
              ),
            ),
//            FlipCard(
//              direction: FlipDirection.HORIZONTAL, // default
//              front: Container(
//                child: CountryCard('View On Map'),
//              ),
//              back: Container(
//                child: CountryDetailCard(
//                    title: 'View On Map', the_color: Colors.teal),
//              ),
//            ),
            GestureDetector(
                onTap: () {
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                        builder: (context) => CountryMap(country)),
//                  );
                  Navigator.pushNamed(context, CountryMap.routeName,
                      arguments: country);
                },
                child: CountryCard('View On Map')),
          ],
        ),
      ),
    );
  }
}

class CountryDetailCard extends StatelessWidget {
  final String title;
  final MaterialColor the_color;
  const CountryDetailCard({
    Key key,
    this.title,
    this.the_color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: the_color,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Center(
            child: Text(
          title,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        )),
      ),
    );
  }
}

class CountryCard extends StatelessWidget {
  final String title;
  CountryCard(this.title);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Center(
            child: Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
