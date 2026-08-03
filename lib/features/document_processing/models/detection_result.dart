import 'dart:math';

class DetectionResult {
  /// Whether a document was successfully detected.
  final bool found;

  /// The four detected document corners in image coordinates.
  final List<Point<double>> corners;

  const DetectionResult({
    required this.found,
    required this.corners,
  });

  /// Returned when no valid document is detected.
  factory DetectionResult.notFound() {
    return const DetectionResult(
      found: false,
      corners: [],
    );
  }

  /// Returned when a document is successfully detected.
  factory DetectionResult.success(
    List<Point<double>> corners,
  ) {
    return DetectionResult(
      found: true,
      corners: corners,
    );
  }
}