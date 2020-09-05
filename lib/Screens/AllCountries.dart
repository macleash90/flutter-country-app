import 'package:flutter/material.dart';
import 'package:flutter_country_house/Screens/Country.dart';
import 'package:dio/dio.dart';

class AllCountries extends StatefulWidget {
  @override
  _AllCountriesState createState() => _AllCountriesState();
}

class _AllCountriesState extends State<AllCountries> {
//  void initS
  List countries = [];
  List filteredCountries = [];
  bool isSearching = false;
  bool countriesLoaded = false;
  void initState() {
    super.initState();
    getCountriesData().then((data) {
      setState(() {
        countries = filteredCountries = data;
        countriesLoaded = true;
      });
    });
  }

  void _filterCounties(value) {
//    print(value);
    setState(() {
      filteredCountries = countries
          .where((country) =>
              country['name'].toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  getCountriesData() async {
    var dio = Dio();
    var response = await dio.get('https://restcountries.eu/rest/v2/all');
//    return response.data;
    return response.data;
  }

  @override
  Widget build(BuildContext context) {
//    getCountriesData();
    return Scaffold(
      appBar: AppBar(
        title: !isSearching
            ? Text("Countries")
            : TextField(
                onChanged: (value) {
                  _filterCounties(value);
                },
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  icon: Icon(Icons.search, color: Colors.white),
                  hintText: 'Search for Country',
                  hintStyle: TextStyle(
                    color: Colors.white,
//                        fontStyle: Style
                  ),
                ),
              ),
        backgroundColor: Colors.pink,
        actions: [
          IconButton(
            icon: Icon(!isSearching ? Icons.search : Icons.cancel),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                filteredCountries = countries;
              });
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: filteredCountries.length > 0
            ? ListView.builder(
                itemCount: filteredCountries.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Country(filteredCountries[index])),
                      );
                    },
                    child: Card(
                      elevation: 10,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        child: Text(filteredCountries[index]['name']),
                      ),
                    ),
                  );
                },
              )
            : (!countriesLoaded
                ? LoadingSpinner()
                : (countriesLoaded && filteredCountries.length < 1
                    ? CountriesNotLoadedCard('No Countries Found')
                    : CountriesNotLoadedCard('Error'))),
      ),
    );
  }
}

class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            child: CircularProgressIndicator(),
            width: 60,
            height: 60,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text('Please Wait...'),
          )
        ],
      ),
    );
  }
}

class CountriesNotLoadedCard extends StatelessWidget {
  final String title;
  CountriesNotLoadedCard(this.title);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Text(title),
      ),
    );
  }
}
