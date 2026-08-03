import 'dart:math' as math;

import 'package:opencv_dart/opencv.dart' as cv;

import '../models/detection_result.dart';
import 'contour_detector.dart';
import 'corner_ordering.dart';
import 'image_preprocessor.dart';

/// Detects a document inside an already loaded image.
///
/// This class performs detection only.
/// It never reads images from disk and never owns image memory.
class DocumentDetector {
  final ImagePreprocessor _preprocessor;
  final ContourDetector _contourDetector;
  final CornerOrdering _cornerOrdering;

  const DocumentDetector({
    ImagePreprocessor? preprocessor,
    ContourDetector? contourDetector,
    CornerOrdering? cornerOrdering,
  })  : _preprocessor = preprocessor ?? const ImagePreprocessor(),
        _contourDetector = contourDetector ?? const ContourDetector(),
        _cornerOrdering = cornerOrdering ?? const CornerOrdering();

  DetectionResult detect(
    cv.Mat image,
  ) {
    final edges = _preprocessor.preprocess(image);

    try {
      final contour =
          _contourDetector.findLargestContour(edges);

      if (contour == null) {
        return DetectionResult.notFound();
      }

      final polygon =
          _contourDetector.approximatePolygon(contour);

      if (!_contourDetector.isDocumentPolygon(
        polygon,
      )) {
        return DetectionResult.notFound();
      }

      final corners = <math.Point<double>>[];

      for (final p in polygon) {
        corners.add(
          math.Point<double>(
            p.x.toDouble(),
            p.y.toDouble(),
          ),
        );
      }

      return DetectionResult.success(
        _cornerOrdering.order(corners),
      );
    } finally {
      edges.dispose();
    }
  }
}