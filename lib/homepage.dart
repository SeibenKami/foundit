// ignore_for_file: prefer_const_constructors, duplicate_ignore, unnecessary_new, unused_import, import_of_legacy_library_into_null_safe, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:foundit/complain_page.dart';
import 'package:foundit/profilepage.dart';
import "package:http/http.dart" as http;
import "dart:convert" as convert;

import 'package:latlong2/latlong.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;
  final String apiKey = "AK2MyelP411wH8oM1ulNVrAgbH1ROMv0";
  LatLng tomtomHQ = LatLng(6.6854, -1.5707);
  //get apiKey => null;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Foundit'),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            // ignore: prefer_const_constructors
            BottomNavigationBarItem(
              // ignore: prefer_const_constructors
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Map',
              backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Item',
              backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Profilepage(),
                      ),
                    );
                  },
                  child: Icon(Icons.person)),
              label: 'Profile',
              backgroundColor: Colors.red,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          onTap: _onItemTapped,
        ),
        body: Center(
          child: Stack(children: <Widget>[
            FlutterMap(
              options: new MapOptions(
                  center: tomtomHQ,
                  zoom: 13.0,
                  onTap: (value, newLat) {
                    setState(() {
                      tomtomHQ = newLat;
                    });
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text("Alert"),
                        content: Text("Lodge complain at this location?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => ComplainPage()));
                            },
                            child: Text("Yes"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("No"),
                          ),
                        ],
                      ),
                    );
                  }),
              layers: [
                new TileLayerOptions(
                  urlTemplate: "https://api.tomtom.com/map/1/tile/basic/main/"
                      "{z}/{x}/{y}.png?key={apiKey}",
                  additionalOptions: {"apiKey": apiKey},
                ),
                new MarkerLayerOptions(markers: [
                  new Marker(
                      width: 60,
                      height: 60,
                      point: tomtomHQ,
                      builder: (BuildContext context) {
                        print(tomtomHQ);
                        return Icon(
                          Icons.location_on,
                          size: 60,
                          color: Colors.black,
                        );
                      }),
                ]),
              ],
            )
          ]),
        ));
  }
}
