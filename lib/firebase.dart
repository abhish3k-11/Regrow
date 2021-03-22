import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

// class _MyHomePageState extends State<MyHomePage> {
//   final fb = FirebaseDatabase.instance;
//   final myController = TextEditingController();
//   final name = "Name";

//   @override
//   Widget build(BuildContext context) {
//     final ref = fb.reference();
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(widget.title),
//         ),
//         body: Container(
//             child: Column(
//           children: <Widget>[
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 Text(name),
//                 Flexible(child: TextField(controller: myController)),
//               ],
//             ),
//             RaisedButton(
//               onPressed: () {
//                 ref.child(name).set(myController.text);
//               },
//               child: Text("Submit"),
//             )
//           ],
//         )));
//   }

//   @override
//   void dispose() {
//     // Clean up the controller when the widget is disposed.
//     myController.dispose();
//     super.dispose();
//   }
// }
