import 'package:flutter/material.dart';
import 'package:simple_map/pages/map_page.dart';
import '../services/map_box_service.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  TextEditingController _searchController = new TextEditingController();

  Future<List<MapBoxPlace>> getData(String query) async {
    return await MapBoxService.searchPlaces(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps'),
      ),
      body: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter city name',
                          icon: Icon(
                            Icons.location_city,
                            color: Colors.grey,
                          )),
                      onChanged: (val) {
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_searchController.text.isNotEmpty)
            Expanded(
              child: FutureBuilder<List<MapBoxPlace>>(
                future: getData(_searchController.text),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                    case ConnectionState.done:
                      if (!snapshot.hasData) {
                        return Center(child: Text('No data to display.'));
                      }
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, int i) => Card(
                          elevation: 5,
                          child: ListTile(
                            title: Text(snapshot.data[i].name),
                            subtitle: Text(snapshot.data[i].details),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) => MapPage(
                                    snapshot.data[i].latitude,
                                    snapshot.data[i].longitude,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    default:
                      return Text('Nothing to display.');
                  }
                },
              ),
            ),
        ],
      ),
    );
  }
}
