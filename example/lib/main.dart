import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:waqiapi/waqiapi.dart' as WaqiApi;

/// This is DEMO app put togther to show the use of the Waqi API only
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter WAQI API Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter WAQI API Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // define the API access here - provide a valid TOKEN!
  WaqiApi.Api api = WaqiApi.Api(token: "{Put a Valid Token In Here or It Will Error}");

  // Some test GPS Coords from the WAQI API docs
  WaqiApi.GpsCoord gpsa = WaqiApi.GpsCoord(lat: 39.379436, long: 116.091230);
  WaqiApi.GpsCoord gpsb = WaqiApi.GpsCoord(lat: 40.235643,long: 116.784382);

  // Var for holding result of API call
  String resultData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Result of API Call:',
            ),
            Text(
              '$resultData'
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {

          // The available API's
          //var result = await api.cityFeed("London");
          //var result = await api.locationFeedIPAddress();
          //var result = await api.locationFeedLatLng(gpsa);
          //var result = await api.mapQuery(gpsa, gpsb);
          var result = await api.searchByName("Bloomsbury");

          // display any result
          print(result);
          setState(() {
            resultData = jsonEncode(result);
          });

        },
        tooltip: 'CallAPI',
        child: Icon(Icons.refresh),
      ), 
    );
  }
}
