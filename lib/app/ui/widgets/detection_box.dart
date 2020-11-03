import 'package:flutter/material.dart';
import 'package:flutter_tflite_object_detection/app/data/models/detection.dart';
import 'package:get/get.dart';

class DetectionBox extends StatelessWidget {
  final Detection detection;

  DetectionBox({this.detection});

  @override
  Widget build(BuildContext context) {
    final size = Get.mediaQuery.size;
    final top = size.height * detection.rect.y;
    final left = size.width * detection.rect.x;
    final width = size.width * detection.rect.w;
    final height = size.height * detection.rect.h;

    return Positioned(
      top: top,
      left: left,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.amber,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(
            "${detection.className} (${detection.confidence})",
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: Colors.amber,
                ),
          ),
        ),
      ),
    );
  }
}
