import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_map/flutter_map.dart';
import 'label.dart';

List<Label> labels = [];
final databaseReference = FirebaseDatabase.instance.reference();
final dbRef = FirebaseDatabase.instance.reference();
DatabaseReference saveLabel(Label label) {
  print("Test Pass 3");
  dbRef.child('labels/').push().set({
    "symbol": label.symbol,
    "latitude": label.latitude,
    "longitude": label.longitude
  }).then((_) {
    print("Works");
  }).catchError((onError) {
    print(onError);
  });
  var id = databaseReference.child('labels/').push();
  id.set({label.toJSON()});
  print("Test Pass 4");
  print(label);
  return id;
}

Future<List<Label>> getAllLabels() async {
  final dbRef = FirebaseDatabase.instance.reference().child('labels/');

  dbRef.once().then((DataSnapshot snapshot) {
    Map<dynamic, dynamic> values = snapshot.value;
    values.forEach((key, values) {
      // print(values['label']);
      Label label;
      label =
          new Label(values['latitude'], values['longitude'], values['symbol']);
      // print(label.label);
      // print(label.latitude);
      // print(label.longitude);
      labels.add(label);
      // print("Test Pass-Labels");
      // print(labels);
    });
  });
  // print("Test Pass-5");
  // print(labels);
  return labels;
}
