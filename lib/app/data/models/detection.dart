class Detection {
  final DetectionRect rect;
  final double confidence;
  final String className;

  Detection({
    this.rect,
    this.confidence,
    this.className,
  });

  factory Detection.fromResult(dynamic result) => Detection(
        rect: DetectionRect.fromResult(result['rect']),
        confidence: result['confidenceInClass'] as double,
        className: result['detectedClass'] as String,
      );

  Map<String, dynamic> toMap() => {
        "confidence": confidence,
        "class": className,
        "rect": rect.toMap(),
      };
}

class DetectionRect {
  final double w;
  final double h;
  final double x;
  final double y;

  DetectionRect({
    this.w,
    this.h,
    this.x,
    this.y,
  });

  factory DetectionRect.fromResult(dynamic result) => DetectionRect(
        w: result["w"] as double,
        h: result["h"] as double,
        x: result["x"] as double,
        y: result["y"] as double,
      );

  Map<String, dynamic> toMap() => {
        "w": w,
        "h": h,
        "x": x,
        "y": y,
      };
}
