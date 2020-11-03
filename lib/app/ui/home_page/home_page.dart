import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite_object_detection/app/controller/home_page_controller.dart';
import 'package:flutter_tflite_object_detection/app/ui/widgets/detection_box.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomePageController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final cameraController = controller.cameraCtl.value;
      final cameraReady = controller.isCameraReady.value;
      final detections = controller.detections;

      if (cameraReady) {
        // scaling camera preview by lightsnap team
        // https://medium.com/lightsnap/making-a-full-screen-camera-application-in-flutter-65db7f5d717b
        final size = Get.mediaQuery.size;
        final deviceRatio = size.width / size.height;
        final xScale = cameraController.value.aspectRatio / deviceRatio;
        // Modify the yScale if you are in Landscape
        final yScale = 1.0;

        final cameraPreview = AspectRatio(
          aspectRatio: deviceRatio,
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.diagonal3Values(xScale, yScale, 1),
            child: CameraPreview(cameraController),
          ),
        );

        // build detection boxes
        final detectionBoxes = detections.map<DetectionBox>(
          (detection) => DetectionBox(
            detection: detection,
          ),
        );

        // stack of camera preview & detection boxes
        return Stack(
          children: [
            cameraPreview,
            ...detectionBoxes,
          ],
        );
      }

      return Container(
        decoration: BoxDecoration(
          color: Colors.grey,
        ),
      );
    });
  }
}
