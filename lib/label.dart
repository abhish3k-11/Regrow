import 'package:firebase_database/firebase_database.dart';

class Label {
  var longitude;
  var latitude;
  String symbol;
  DatabaseReference _id;

  Label(this.latitude, this.longitude, this.symbol);

  void setId(DatabaseReference _id) {
    this._id = _id;
    print("TestPass 2");
    print(this._id);
  }

  Map<String, dynamic> toJSON() {
    print("Inside Map");
    print(_id);
    print(this);
    return {
      'latitude': this.latitude,
      'longitude': this.longitude,
      'label': this.symbol
    };
  }

  Label createLabel(record) {
    Map<String, dynamic> attributes = {
      'latitude': null,
      'longitude': null,
      'label': ''
    };

    record.forEach((key, value) => {attributes[key] = value});
    Label label = new Label(
        attributes['latitude'], attributes['longitude'], attributes['symbol']);
    return label;
  }
}
