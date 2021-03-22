import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  var location = "";
  String dropdownValue = "danger";
  void getCurrentLocation() async {
    var position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator().getLastKnownPosition();
    setState(() {
      location = "$position";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get Your Location"),
      ),
      body: Center(
        child: Align(
          alignment: Alignment.topCenter,
          child: Row(
            children: <Widget>[
              //               floatingActionButton: FloatingActionButton(
              //   onPressed: _incrementCounter,
              //   tooltip: 'Increment',
              //   child: Icon(Icons.add),
              // ), // This
              //   floatingActionButton: FloatingActionButton(
              //   backgroundColor: Colors.white,
              //   child: DropdownButton<String>(
              //     value: dropdownValue,
              //     underline: Container(),
              //     icon: Icon(Icons.arrow_downward),
              //     iconSize: 20.0, // can be changed, default: 24.0
              //     iconEnabledColor: Colors.red,
              //     onChanged: (String newValue) {
              //       setState(() {
              //         dropdownValue = newValue;
              //       });
              //     },
              //     items: <String>['danger', 'food', 'home', 'rock']
              //         .map<DropdownMenuItem<String>>((String value) {
              //       return DropdownMenuItem<String>(
              //         value: value,
              //         child: Container(
              //           width: 200,
              //           child: Row(
              //             children: <Widget>[
              //               Image(
              //                 image: AssetImage('./assets/' + value + '.png'),
              //                 width: 50,
              //                 height: 50,
              //               ),
              //               Text(value)
              //             ],
              //           ),
              //         ),
              //       );
              //     }).toList(),
              //   ),
              // ),
              FlatButton(
                //     disabledColor: Colors.red,

                // disabledTextColor: Colors.black,

                padding: const EdgeInsets.all(20),

                textColor: Colors.white,

                color: Colors.green,

                onPressed: () {
                  Navigator.pushNamed(context, 'map');
                },

                child: Text('Enabled Button'),
              ),
              FlatButton(
                //     disabledColor: Colors.red,

                // disabledTextColor: Colors.black,

                padding: const EdgeInsets.all(20),

                textColor: Colors.white,

                color: Colors.green,

                onPressed: () {
                  Navigator.pushNamed(context, 'bluetooth');
                },

                child: Text('Enabled Button2'),
              ),
            ],
          ),
        ),
        // children: <Widget>[
        //   Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: <Widget>[
        //       Icon(
        //         Icons.location_on,
        //         size: 46.0,
        //         color: Colors.red[400],
        //       ),
        //       SizedBox(
        //         height: 10.0,
        //       ),
        //       Text("Position : $location"),
        //       FlatButton(
        //           onPressed: () {
        //             getCurrentLocation();
        //           },
        //           shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(8.0),
        //               side: BorderSide(color: Colors.green[500])),
        //           color: Colors.green[300],
        //           child: Text.rich(TextSpan(
        //               text: "Get",
        //               style: TextStyle(
        //                 color: Colors.red[400],
        //                 fontSize: 24.0,
        //                 fontFamily: 'ag',
        //               ),
        //               children: <TextSpan>[
        //                 TextSpan(
        //                   text: " Your",
        //                   style: TextStyle(
        //                     color: Colors.blue,
        //                     fontWeight: FontWeight.bold,
        //                     fontSize: 24.0,
        //                     fontFamily: 'ag',
        //                   ),
        //                 ),
        //                 TextSpan(
        //                   text: " Location",
        //                   style: TextStyle(
        //                     color: Colors.red[400],
        //                     fontSize: 24.0,
        //                     fontFamily: 'ag',
        //                   ),
        //                 )
        //               ]))),
        //     ],
        //   ),
        // ]),
      ),
    );
  }
}
