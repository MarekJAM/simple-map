import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simple_map/util/array_util.dart';

class MapBoxService {

  static String accessToken = "pk.eyJ1IjoibWFyZWtqYW0iLCJhIjoiY2tnaTZ1NnV3MGxmbjJ6dGUzcWRjbnFnMyJ9.ZQJsvBzzk-FSDOyJEuQ5Tg";

  static Future<List<MapBoxPlace>> searchPlaces(String searchQuery, [int limit = 10]) async {
    List<MapBoxPlace> result = [];
    var response = await http.get("https://api.mapbox.com/geocoding/v5/mapbox.places/$searchQuery"
        ".json?access_token=$accessToken&autocomplete=true&types=place&limit=$limit");

    try {
      var decodedJson = jsonDecode(response.body);
      var features = decodedJson["features"];
      if (ArrayUtil.isNotEmpty(features)) {
        for (dynamic place in features) {
          var mapBoxPlace = MapBoxPlace.fromJson(place);
          result.add(mapBoxPlace);
        }
      }
    } catch (err) {
      print(err);
    }

    return (ArrayUtil.isNotEmpty(result)) ? result : null;
  }

  static Future<MapBoxPlace> lookup(double latitude, double longitude) async {
    var response = await http.get("https://api.mapbox.com/geocoding/v5/mapbox.places/$longitude,$latitude"
        ".json?access_token=$accessToken&types=region");

    try {
      var decodedJson = jsonDecode(response.body);
      var features = decodedJson["features"];
      if (ArrayUtil.isNotEmpty(features)) {
        for (dynamic place in features) {
          return MapBoxPlace.fromJson(place);
        }
      }
    } catch (err) {
      print(err);
    }

    return null;
  }
}

class MapBoxPlace {
  String id;
  String name;
  String details;
  double latitude;
  double longitude;

  MapBoxPlace.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    name = json['text'];
    var tempDetails = json['place_name'];
    details = tempDetails.substring(tempDetails.indexOf(",") +2 , tempDetails.length);
    latitude = double.parse(json['center'][1].toString());
    longitude = double.parse(json['center'][0].toString());
  }
}
