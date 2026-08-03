import 'dart:math' as math;

import 'package:opencv_dart/opencv.dart' as cv;

import 'enhancement_mode.dart';

/// Represents a fully processed document.
///
/// At this stage, the document has:
/// - been detected
/// - perspective corrected
/// - enhanced
///
/// The caller owns [image] and must dispose it when no longer needed.
class ProcessedDocument {
  /// Final processed document image.
  final cv.Mat image;

  /// Ordered document corners in the original image.
  final List<math.Point<double>> corners;

  /// Enhancement mode used to generate [image].
  final EnhancementMode enhancementMode;

  const ProcessedDocument({
    required this.image,
    required this.corners,
    required this.enhancementMode,
  });

  /// Releases the native image memory.
  ///
  /// Safe to call once the processed image is no longer required.
  void dispose() {
    image.dispose();
  }
}