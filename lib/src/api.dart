// Copyright (c) 2019, Steve Rogers. All rights reserved. Use of this source code
// is governed by an Apache License 2.0 that can be found in the LICENSE file.
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// Class representing a GPS coordinate using [lat] and [long]
class GpsCoord {
  final double lat;
  final double long;
  GpsCoord({@required this.lat,@required this.long});
}

/// API to access the WAQI API -  A valid [token] is required to use the API. 
/// See https://aqicn.org/api/ and https://aqicn.org/json-api/doc/ for more details 
class Api {

  final String token;
  final String _endpoint = "https://api.waqi.info";

  Api({@required this.token});

  /// Internal call to query our API
  _callAPI(String url) async {
    var result = await http.get(Uri.encodeFull(url));
    if(result.statusCode == 200){
        return jsonDecode(result.body);
    } else {
     throw Exception("WAQIAPI API Error calling $url. Status code: ${result.statusCode}");
    }
  }

  /// Get the real-time Air Quality index for a given station in a [city]
  cityFeed(String city) async {
    String apiUrl = "$_endpoint/feed/$city/?token=$token";
    return _callAPI(apiUrl);
  }

  /// Search for the nearest station from a given latitude/longitude defined by [gps]
  locationFeedLatLng(GpsCoord gps) async {
    String apiUrl = "$_endpoint/feed/geo:${gps.lat};${gps.long}/?token=$token";
    return _callAPI(apiUrl);
  }

  /// Get the nearest station close to the user location, based on the IP adress information.
  locationFeedIPAddress() async {
    String apiUrl = "$_endpoint/feed/here/?token=$token";
    return _callAPI(apiUrl);
  }

  /// Get all the stations within a given lat/lng bounds defined by [coords1]  and [coords2]
  mapQuery( GpsCoord coords1, GpsCoord coords2) async {
    String apiUrl = "$_endpoint/map/bounds/?latlng=${coords1.lat},${coords1.long},${coords2.lat},${coords2.long}&token=$token";
    return _callAPI(apiUrl);    
  }

  /// search stations by [name]
  searchByName(String name) async {
    String apiUrl = "$_endpoint/search/?keyword=$name&token=$token";
    return _callAPI(apiUrl);
  }

}
