import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:regrow/label.dart';

import 'database.dart';
// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:core';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mapbox_gl/mapbox_gl.dart';
import 'dart:math' as math;
import 'main.dart';

List<Label> downloadall = [];
math.Random rnd = new math.Random();

abstract class ExamplePage extends StatelessWidget {
  const ExamplePage(this.leading, this.title);

  final Widget leading;
  final String title;
}

final List<ExamplePage> _allPages = <ExamplePage>[
  PlaceSymbolPage(),
];

class MapsDemo extends StatelessWidget {
  //FIXME: Add your Mapbox access token here
  static const String ACCESS_TOKEN =
      "pk.eyJ1IjoiYXNod2FuaTEiLCJhIjoiY2tsbmU4M213MGhnZTJvbXMzeDVqYzQxeiJ9.ZLq86_9zKGNX2-JaKywuCw";

  void _pushPage(BuildContext context, ExamplePage page) async {
    if (!kIsWeb) {
      final location = Location();
      final hasPermissions = await location.hasPermission();
      if (hasPermissions != PermissionStatus.granted) {
        await location.requestPermission();
      }
    }
    Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (_) => Scaffold(
              appBar: AppBar(title: Text(page.title)),
              body: page,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MapboxMaps')),
      body: ListView.builder(
        itemCount: _allPages.length,
        itemBuilder: (_, int index) => ListTile(
          leading: _allPages[index].leading,
          title: Text(_allPages[index].title),
          onTap: () => _pushPage(context, _allPages[index]),
        ),
      ),
    );
  }
}

class PlaceSymbolPage extends ExamplePage {
  PlaceSymbolPage() : super(const Icon(Icons.place), 'Regrow');

  @override
  Widget build(BuildContext context) {
    return const PlaceSymbolBody();
  }
}

class PlaceSymbolBody extends StatefulWidget {
  const PlaceSymbolBody();

  @override
  State<StatefulWidget> createState() => PlaceSymbolBodyState();
}

class PlaceSymbolBodyState extends State<PlaceSymbolBody> {
  PlaceSymbolBodyState();

  static final LatLng center = const LatLng(30.7333, 76.7794);
  final Location location = Location();

  LocationData _location;
  String _error;
  double latitudedata;
  double longitudedata;
  int label;
  MapboxMapController controller;
  int _symbolCount = 0;
  Symbol _selectedSymbol;
  bool _iconAllowOverlap = false;
  void _savedata(todo data) {
    var json = jsonCodec.encode(data);
    print("json=$json");
    //var httpClient = createHttpClient();
    //httpClient.post();
    return;
  }

  // void placeInAdd(args) {
  //   var label = new Label(0.0, 0.0, "airport");
  //   label.setId(saveLabel(label));
  // }

  Future<void> _getLocation() async {
    setState(() {
      _error = null;
    });
    try {
      final LocationData _locationResult = await location.getLocation();
      setState(() {
        _location = _locationResult;
        latitudedata = _location.latitude;
        longitudedata = _location.longitude;
        label = 1;
        _savedata(new todo(label, latitudedata, longitudedata));
      });
    } on PlatformException catch (err) {
      setState(() {
        _error = err.code;
      });
    }
  }

  void _onMapCreated(MapboxMapController controller) {
    this.controller = controller;
    controller.onSymbolTapped.add(_onSymbolTapped);
  }

  void _onStyleLoaded() {
    addImageFromAsset("assetImage", "assets/symbols/custom-icon.png");
    addImageFromUrl(
        "networkImage", Uri.parse("https://via.placeholder.com/50"));
  }

  @override
  void dispose() {
    controller?.onSymbolTapped?.remove(_onSymbolTapped);
    super.dispose();
  }

  /// Adds an asset image to the currently displayed style
  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return controller.addImage(name, list);
  }

  /// Adds a network image to the currently displayed style
  Future<void> addImageFromUrl(String name, Uri uri) async {
    var response = await http.get(uri);
    return controller.addImage(name, response.bodyBytes);
  }

  void _onSymbolTapped(Symbol symbol) {
    if (_selectedSymbol != null) {
      _updateSelectedSymbol(
        const SymbolOptions(iconSize: 1.0),
      );
    }
    setState(() {
      _selectedSymbol = symbol;
    });
    _updateSelectedSymbol(
      SymbolOptions(
        iconSize: 1.4,
      ),
    );
  }

  void _updateSelectedSymbol(SymbolOptions changes) {
    controller.updateSymbol(_selectedSymbol, changes);
  }

  void add() {
    String iconImage = 'customFont';
    int symbolCount1 = rnd.nextInt(10);
    var data = [
      "airport-15",
      "firestation-15",
      "lodging-15",
      //"danger-15",
      "cafe-15",
      "industry-15",
      "beer-15",
    ];
    LatLng geometry = LatLng(
      center.latitude + sin(_symbolCount + symbolCount1 * pi / 6.0) / 20.0,
      center.longitude + cos(_symbolCount + symbolCount1 * pi / 6.0) / 20.0,
    );
    symbolCount1 = 0;
    String label1 = data[rnd.nextInt(7)];
    controller.addSymbol(iconImage == 'customFont'
        ? SymbolOptions(
            geometry: geometry,
            iconImage: label1,
            fontNames: ['DIN Offc Pro Bold', 'Arial Unicode MS Regular'],
            textField: label1,
            textSize: 12.5,
            textOffset: Offset(0, 0.8),
            textAnchor: 'top',
            textColor: '#000000',
            textHaloBlur: 1,
            textHaloColor: '#ffffff',
            textHaloWidth: 0.8,
          )
        : SymbolOptions(
            geometry: geometry,
            iconImage: iconImage,
          ));
    var label =
        new Label(geometry.latitude, geometry.longitude, data[rnd.nextInt(7)]);
    label.setId(saveLabel(label));
    print("TestPass 1");
    setState(() {
      _symbolCount += 1;
    });
  }

  void _add(String iconImage) {
    List<int> availableNumbers = Iterable<int>.generate(12).toList();
    controller.symbols.forEach(
        (s) => availableNumbers.removeWhere((i) => i == s.data['count']));
    if (availableNumbers.isNotEmpty) {
      controller.addSymbol(_getSymbolOptions(iconImage, availableNumbers.first),
          {'count': availableNumbers.first});

      setState(() {
        _symbolCount += 1;
      });
    }
  }

  SymbolOptions _getSymbolOptions(String iconImage, int symbolCount) {
    LatLng geometry = LatLng(
      center.latitude + sin(symbolCount * pi / 6.0) / 20.0,
      center.longitude + cos(symbolCount * pi / 6.0) / 20.0,
    );
    return iconImage == 'customFont'
        ? SymbolOptions(
            geometry: geometry,
            iconImage: 'airport-15',
            fontNames: ['DIN Offc Pro Bold', 'Arial Unicode MS Regular'],
            textField: 'Airport',
            textSize: 12.5,
            textOffset: Offset(0, 0.8),
            textAnchor: 'top',
            textColor: '#000000',
            textHaloBlur: 1,
            textHaloColor: '#ffffff',
            textHaloWidth: 0.8,
          )
        : SymbolOptions(
            geometry: geometry,
            iconImage: iconImage,
          );
  }

  void addall() {}
  Future<void> _addAll() async {
    List<int> symbolsToAddNumbers = Iterable<int>.generate(12).toList();
    print("Test Pass-1");
    print(downloadall);
    print(downloadall.length);
    var data = [
      "airport",
      "firestation",
      "lodging-15",
      "danger-15",
      "cafe-15",
      "industry-15",
      "beer-15",
    ];
    LatLng geometry = LatLng(
      center.latitude + sin(_symbolCount * pi / 6.0) / 20.0,
      center.longitude + cos(_symbolCount * pi / 6.0) / 20.0,
    );

    String iconImage = 'customFont';
    String label1 = data[rnd.nextInt(7)];
    for (int i = 0; i < downloadall.length + 1; i++) {
      LatLng geometry = LatLng(
        downloadall[i].latitude,
        downloadall[i].longitude,
      );
      var label1 = downloadall[i].symbol;
      controller.addSymbol(iconImage == 'customFont'
          ? SymbolOptions(
              geometry: geometry,
              iconImage: label1, //,
              fontNames: ['DIN Offc Pro Bold', 'Arial Unicode MS Regular'],
              textField: label1,
              textSize: 12.5,
              textOffset: Offset(0, 0.8),
              textAnchor: 'top',
              textColor: '#000000',
              textHaloBlur: 1,
              textHaloColor: '#ffffff',
              textHaloWidth: 0.8,
            )
          : SymbolOptions(
              geometry: geometry,
              iconImage: iconImage,
            ));
      setState(() {});
    }
    downloadall.clear();
    // print("Test Pass-2");
    // controller.symbols.forEach(
    //     (s) => symbolsToAddNumbers.removeWhere((i) => i == s.data['count']));

    // if (symbolsToAddNumbers.isNotEmpty) {
    //   final List<SymbolOptions> symbolOptionsList = symbolsToAddNumbers
    //       .map((i) => _getSymbolOptions(iconImage, i))
    //       .toList();
    //   controller.addSymbols(symbolOptionsList,
    //       symbolsToAddNumbers.map((i) => {'count': i}).toList());

    //   var label = new Label(
    //       geometry.latitude, geometry.longitude, data[rnd.nextInt(7)]);
    //   label.setId(saveLabel(label));
    //   print("TestPass 1");
    //   setState(() {
    //     _symbolCount += symbolOptionsList.length;
    //   });
    // }
  }

  void _remove() {
    controller.removeSymbol(_selectedSymbol);
    setState(() {
      _selectedSymbol = null;
      _symbolCount -= 1;
    });
  }

  void _removeAll() {
    controller.removeSymbols(controller.symbols);
    setState(() {
      _selectedSymbol = null;
      _symbolCount = 0;
    });
  }

  void _changePosition() {
    final LatLng current = _selectedSymbol.options.geometry;
    final Offset offset = Offset(
      center.latitude - current.latitude,
      center.longitude - current.longitude,
    );
    _updateSelectedSymbol(
      SymbolOptions(
        geometry: LatLng(
          center.latitude + offset.dy,
          center.longitude + offset.dx,
        ),
      ),
    );
  }

  Future<void> _toggleDraggable() async {
    bool draggable = _selectedSymbol.options.draggable;
    if (draggable == null) {
      // default value
      draggable = false;
    }

    _updateSelectedSymbol(
      SymbolOptions(draggable: !draggable),
    );
  }

  Future<void> _toggleVisible() async {
    double current = _selectedSymbol.options.iconOpacity;
    if (current == null) {
      // default value
      current = 1.0;
    }

    _updateSelectedSymbol(
      SymbolOptions(iconOpacity: current == 0.0 ? 1.0 : 0.0),
    );
  }

  void _getLatLng() async {
    LatLng latLng = await controller.getSymbolLatLng(_selectedSymbol);
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(latLng.toString()),
      ),
    );
  }

  void download() {
    print("Test Pass-1");
    getAllLabels().then((label) {
      print(labels[1].symbol);
      downloadall = labels;
    });
    print("Test Download");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(5, 0, 5, 10),
          child: SizedBox(
            width: double.infinity,
            height: 400.0,
            child: MapboxMap(
              accessToken: MapsDemo.ACCESS_TOKEN,
              onMapCreated: _onMapCreated,
              onStyleLoadedCallback: _onStyleLoaded,
              initialCameraPosition: const CameraPosition(
                target: LatLng(30.7333, 76.7794),
                //30.7333° N, 76.7794
                zoom: 11.0,
              ),
            ),
          ),
        ),
        Container(
          height: 50,
          width: 400,
          padding: EdgeInsets.all(10),
          child: Text(
            '    LATITUDE:' +
                (_error ?? '${latitudedata ?? "unknown"}') +
                '    LONGITUDE:' +
                (_error ?? '${longitudedata ?? "unknown"}'),
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(5),
                          height: 60,
                          width: 150,
                          child: OutlinedButton(
                            child: const Text('Add'),
                            onPressed: () {
                              add();
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          height: 60,
                          width: 150,
                          child: OutlinedButton(
                            child: const Text('Add all'),
                            onPressed: () =>
                                (_symbolCount == 12) ? null : _addAll(),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          height: 60,
                          width: 150,
                          child: OutlinedButton(
                            child: const Text('Remove'),
                            onPressed:
                                (_selectedSymbol == null) ? null : _remove,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          height: 60,
                          width: 150,
                          child: OutlinedButton(
                            child: const Text('Remove all'),
                            onPressed: (_symbolCount == 0) ? null : _removeAll,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(5),
                          height: 60,
                          width: 150,
                          child: OutlinedButton(
                              child: const Text('Download'),
                              onPressed: () {
                                download();
                              }),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          height: 60,
                          width: 150,
                          child: OutlinedButton(
                            child: const Text('Toggle draggable'),
                            onPressed: (_selectedSymbol == null)
                                ? null
                                : _toggleDraggable,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          height: 60,
                          width: 150,
                          child: OutlinedButton(
                            child: const Text('Change position'),
                            onPressed: (_selectedSymbol == null)
                                ? null
                                : _changePosition,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          height: 60,
                          width: 150,
                          child: OutlinedButton(
                              child: const Text('LatLng'),
                              onPressed: () {
                                (_selectedSymbol == null) ? null : _getLatLng();
                                _getLocation();
                              }),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

const jsonCodec = const JsonCodec();

class todo {
  int label;
  double lat;
  double long;
  todo(this.label, this.lat, this.long);
  Map toJson() {
    return {"label": label, "latitude": lat, "longitude": long};
  }
}
