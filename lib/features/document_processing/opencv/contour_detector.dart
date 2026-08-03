import 'package:opencv_dart/opencv.dart' as cv;

/// Detects and processes document contours from an edge image.
///
/// This class is intentionally focused only on contour extraction.
/// It does not perform preprocessing, corner ordering or perspective
/// correction.
class ContourDetector {
  const ContourDetector();

  /// Minimum contour area in pixels.
  ///
  /// Small contours are usually caused by text, shadows or image noise.
  static const double _minimumContourArea = 1000.0;

  /// Polygon approximation epsilon as a percentage of contour perimeter.
  static const double _approximationFactor = 0.02;

  /// Returns the largest valid contour in the edge image.
  ///
  /// Returns `null` if no suitable contour is found.
  cv.VecPoint? findLargestContour(cv.Mat edgeImage) {
    final (contours, _) = cv.findContours(
      edgeImage,
      cv.RETR_LIST,
      cv.CHAIN_APPROX_SIMPLE,
    );

    cv.VecPoint? largestContour;
    double largestArea = 0;

    for (final contour in contours) {
      final area = cv.contourArea(contour);

      if (area < _minimumContourArea) {
        continue;
      }

      if (area > largestArea) {
        largestArea = area;
        largestContour = contour;
      }
    }

    return largestContour;
  }

  /// Approximates a contour into a polygon.
  ///
  /// The returned polygon may contain any number of points.
  /// The caller decides whether a valid document has been found
  /// (typically by checking for exactly four corners).
  cv.VecPoint approximatePolygon(
    cv.VecPoint contour,
  ) {
    final perimeter = cv.arcLength(
      contour,
      true,
    );

    return cv.approxPolyDP(
      contour,
      perimeter * _approximationFactor,
      true,
    );
  }

  /// Returns true if the polygon represents a quadrilateral.
  bool isDocumentPolygon(
    cv.VecPoint polygon,
  ) {
    return polygon.length == 4;
  }
}