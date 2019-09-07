# waqiapi

*WAQIAPI* is a Flutter package that can be used to access the World Air Quality Index (WAQI) [public JSON API](https://aqicn.org/json-api/doc/). To access the API you will need to register and obtain a token, more details can be found [here](https://aqicn.org/data-platform/token/#/).


## Using the API
Just add the package to your project then import into you code, see below.

```
import 'package:waqiapi/waqiapi.dart' as WaqiApi
```

You will then have access to the API along with a helper GpsCoord class. To use the API just define the following (using a valid token):

```
WaqiApi.Api api = WaqiApi.Api(token: "{Put a Valid Token In Here or It Will Error}");
```

You can define sets of Gps coords using the helper class: 

```
WaqiApi.GpsCoord gpsa = WaqiApi.GpsCoord(lat: 39.379436, long: 116.091230);
WaqiApi.GpsCoord gpsb = WaqiApi.GpsCoord(lat: 40.235643,long: 116.784382);
```

These can then be used to pass into the API. The following are valid calls available in the API (all are async) and all return a JSON object:

```
var feedResult = await api.cityFeed("London");
var ipResult = await api.locationFeedIPAddress();
var gpsResult = await api.locationFeedLatLng(gpsa);
var queryResult = await api.mapQuery(gpsa, gpsb);
var nameResult = await api.searchByName("Bloomsbury");
```


See the example project for more details.





## Getting Started

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
