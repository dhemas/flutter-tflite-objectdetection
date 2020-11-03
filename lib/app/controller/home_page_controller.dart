import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter_tflite_object_detection/app/data/models/detection.dart';
import 'package:get/get.dart';
import 'package:tflite/tflite.dart';
import '../utils.dart';

const double MINIMUM_CONFIDENCE = 0.4;
const double IMAGE_MEAN = 128.0;
const double IMAGE_STD = 128.0;
const int RESULT_PER_CLASS = 2;

class HomePageController extends GetxController {
  HomePageController();

  final isCameraReady = false.obs;
  final cameraError = ''.obs;
  final cameras = List<CameraDescription>().obs;
  final cameraCtl = Rx<CameraController>();
  final detections = List<Detection>().obs;

  bool _isProcessing = false;

  @override
  void onInit() async {
    super.onInit();

    await _initTfLite();
    startCamera();
  }

  Future<void> startCamera() async {
    cameras.value = await availableCameras();
    cameraCtl.value = CameraController(cameras.first, ResolutionPreset.high);
    await cameraCtl.value.initialize();
    isCameraReady.value = cameraCtl.value.value.isInitialized;

    // start stream
    cameraCtl.value.startImageStream((image) => _detectObject(image));
  }

  Future<void> _initTfLite() async {
    final res = await Tflite.loadModel(
      model: "assets/tflite/detect.tflite",
      labels: "assets/tflite/labelmap.txt",
      numThreads: 4,
      isAsset: true,
      useGpuDelegate: false,
    );

    log(res);
  }

  Future<void> _detectObject(CameraImage image) async {
    if (!_isProcessing) {
      _isProcessing = true;
      final timeStart = DateTime.now().millisecondsSinceEpoch;

      final result = await Tflite.detectObjectOnFrame(
        bytesList: image.planes.map((plane) {
          return plane.bytes;
        }).toList(),
        model: "SSDMobileNet",
        imageHeight: image.height,
        imageWidth: image.width,
        imageMean: IMAGE_MEAN,
        imageStd: IMAGE_STD,
        threshold: MINIMUM_CONFIDENCE,
        numResultsPerClass: RESULT_PER_CLASS,
        asynch: true,
      );

      detections.clear();
      detections.addAll(
          result.map<Detection>((i) => Detection.fromResult(i)).toList());

      final timeFinish = DateTime.now().millisecondsSinceEpoch - timeStart;

      _isProcessing = false;
      log("processing time: $timeFinish ms \n${detections.stringify()}");
    }
  }

  @override
  void onClose() {
    // dispose camera ctl
    cameraCtl.value.dispose();

    super.onClose();
  }
}
