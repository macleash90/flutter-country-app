import 'package:flutter/material.dart';
import 'package:flutter_country_house/Screens/Country.dart';
import 'package:dio/dio.dart';

class AllCountries extends StatefulWidget {
  @override
  _AllCountriesState createState() => _AllCountriesState();
}

class _AllCountriesState extends State<AllCountries> {
//  void initS
  Future<List> countries;
  bool isSearching = false;
  void initState() {
    super.initState();
    countries = getCountriesData();
  }

  void _filterCounties(value) {
    print(value);
  }

  Future<List> getCountriesData() async {
    var dio = Dio();
    var response = await dio.get('https://restcountries.eu/rest/v2/all');
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
              });
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: FutureBuilder<List>(
          future: countries, // a previously-obtained Future<String> or null
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
//            List<Widget> children;
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Country(snapshot.data[index])),
                      );
                    },
                    child: Card(
                      elevation: 10,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        child: Text(snapshot.data[index]['name']),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Error: ${snapshot.error}'),
                    )
                  ],
                ),
              );
            } else {
              return LoadingSpinner();
            }
          },
        ),
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
