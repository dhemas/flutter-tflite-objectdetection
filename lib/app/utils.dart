import 'dart:convert';

import 'package:flutter_tflite_object_detection/app/data/models/detection.dart';

extension Log on List<Detection> {
  String stringify() {
    final jsonEncoder = JsonEncoder.withIndent(' ');
    return this.map<String>((e) => jsonEncoder.convert(e.toMap())).join("\n");
  }
}
