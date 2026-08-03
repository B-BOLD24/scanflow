import 'dart:io';

import 'package:opencv_dart/opencv.dart' as cv;

import '../models/detection_result.dart';
import '../models/enhancement_mode.dart';
import '../models/processed_document.dart';
import '../opencv/document_detector.dart';
import '../opencv/image_enhancer.dart';
import '../opencv/perspective_corrector.dart';

/// Coordinates the complete document processing pipeline.
///
/// Pipeline:
/// 1. Load image
/// 2. Detect document
/// 3. Correct perspective
/// 4. Enhance image
/// 5. Return processed document
class ProcessingService {
  final DocumentDetector _documentDetector;
  final PerspectiveCorrector _perspectiveCorrector;
  final ImageEnhancer _imageEnhancer;

  const ProcessingService({
    DocumentDetector? documentDetector,
    PerspectiveCorrector? perspectiveCorrector,
    ImageEnhancer? imageEnhancer,
  })  : _documentDetector =
            documentDetector ?? const DocumentDetector(),
        _perspectiveCorrector =
            perspectiveCorrector ?? const PerspectiveCorrector(),
        _imageEnhancer =
            imageEnhancer ?? const ImageEnhancer();

  Future<ProcessedDocument?> process(
    File imageFile, {
    EnhancementMode enhancementMode =
        EnhancementMode.color,
  }) async {
    cv.Mat? originalImage;
    cv.Mat? correctedImage;
    cv.Mat? enhancedImage;

    try {
      originalImage = cv.imread(imageFile.path);

      final DetectionResult detection =
          _documentDetector.detect(
        originalImage,
      );

      if (!detection.found) {
        return null;
      }

      correctedImage =
          _perspectiveCorrector.correct(
        originalImage,
        detection.corners,
      );

      enhancedImage =
          _imageEnhancer.enhance(
        correctedImage,
        enhancementMode,
      );

      return ProcessedDocument(
        image: enhancedImage,
        corners: detection.corners,
        enhancementMode: enhancementMode,
      );
    } finally {
      originalImage?.dispose();
      correctedImage?.dispose();
    }
  }
}