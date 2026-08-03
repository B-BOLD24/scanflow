import 'package:opencv_dart/opencv.dart' as cv;

import '../models/enhancement_mode.dart';

/// Applies visual enhancement to a perspective-corrected document.
///
/// The caller owns the returned Mat and must dispose it.
class ImageEnhancer {
  const ImageEnhancer();

  cv.Mat enhance(cv.Mat image, EnhancementMode mode) {
    switch (mode) {
      case EnhancementMode.original:
        return _original(image);

      case EnhancementMode.color:
        return _color(image);

      case EnhancementMode.blackAndWhite:
        return _blackAndWhite(image);
    }
  }

  /// Returns an unchanged copy of the image.
  cv.Mat _original(cv.Mat image) {
    return image.clone();
  }

  /// Slightly improves brightness and contrast while preserving color.
  cv.Mat _color(cv.Mat image) {
    return image.convertTo(image.type, alpha: 1.15, beta: 10);
  }

  /// Produces a clean black & white scanned document.
  cv.Mat _blackAndWhite(cv.Mat image) {
    final gray = cv.cvtColor(image, cv.COLOR_BGR2GRAY);

    final blurred = cv.gaussianBlur(gray, (5, 5), 0);

    gray.dispose();

    final thresholded = cv.adaptiveThreshold(
      blurred,
      255,
      cv.ADAPTIVE_THRESH_GAUSSIAN_C,
      cv.THRESH_BINARY,
      21,
      15,
    );

    blurred.dispose();

    return thresholded;
  }
}
