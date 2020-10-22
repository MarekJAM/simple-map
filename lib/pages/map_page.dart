import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:simple_map/services/map_box_service.dart';

class MapPage extends StatefulWidget {
  final double latitude;
  final double longitude;
  const MapPage(this.latitude, this.longitude);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FlutterMap(
        options: MapOptions(
          minZoom: 1,
          center: LatLng(widget.latitude, widget.longitude),
          zoom: 12
        ),
        layers: [
          TileLayerOptions(
            urlTemplate:
                "https://api.mapbox.com/styles/v1/marekjam/ckgibaahm2egp19obet5383jo/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibWFyZWtqYW0iLCJhIjoiY2tnaTVjN3J1MXAxbjJ0czFjcnU5MDd2MSJ9.VM2QAYEEmVlFho61-EO5hQ",
            additionalOptions: {
              'accessToken': MapBoxService.accessToken,
              'id': 'mapbox.mapbox-streets-v7'
            },
          ),
        ],
      ),
    );
  }
}
