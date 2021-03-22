import 'package:regrow/label.dart';

import 'database.dart';

void placeInAdd(args) {
  var label = new Label(0.0, 0.0, "airport");
  label.setId(saveLabel(label));
}
