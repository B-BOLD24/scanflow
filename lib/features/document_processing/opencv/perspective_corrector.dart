import 'dart:math' as math;

import 'package:opencv_dart/opencv.dart' as cv;

/// Corrects document perspective using four ordered corners.
///
/// Corner order:
/// 0 -> Top Left
/// 1 -> Top Right
/// 2 -> Bottom Right
/// 3 -> Bottom Left
///
/// The caller owns the returned Mat and must dispose it.
class PerspectiveCorrector {
  const PerspectiveCorrector();

  cv.Mat correct(
    cv.Mat image,
    List<math.Point<double>> corners,
  ) {
    if (corners.length != 4) {
      throw ArgumentError(
        'Exactly 4 ordered corners are required.',
      );
    }

    final topLeft = corners[0];
    final topRight = corners[1];
    final bottomRight = corners[2];
    final bottomLeft = corners[3];

    final widthTop = _distance(
      topLeft,
      topRight,
    );

    final widthBottom = _distance(
      bottomLeft,
      bottomRight,
    );

    final heightLeft = _distance(
      topLeft,
      bottomLeft,
    );

    final heightRight = _distance(
      topRight,
      bottomRight,
    );

    final outputWidth = math.max(
      widthTop,
      widthBottom,
    ).round();

    final outputHeight = math.max(
      heightLeft,
      heightRight,
    ).round();

    final sourcePoints = cv.VecPoint.fromList([
      cv.Point(
        topLeft.x.round(),
        topLeft.y.round(),
      ),
      cv.Point(
        topRight.x.round(),
        topRight.y.round(),
      ),
      cv.Point(
        bottomRight.x.round(),
        bottomRight.y.round(),
      ),
      cv.Point(
        bottomLeft.x.round(),
        bottomLeft.y.round(),
      ),
    ]);

    final destinationPoints = cv.VecPoint.fromList([
      cv.Point(0, 0),
      cv.Point(outputWidth - 1, 0),
      cv.Point(outputWidth - 1, outputHeight - 1),
      cv.Point(0, outputHeight - 1),
    ]);

    final transformMatrix = cv.getPerspectiveTransform(
      sourcePoints,
      destinationPoints,
    );

    final corrected = cv.warpPerspective(
      image,
      transformMatrix,
      (
        outputWidth,
        outputHeight,
      ),
    );

    sourcePoints.dispose();
    destinationPoints.dispose();
    transformMatrix.dispose();

    return corrected;
  }

  double _distance(
    math.Point<double> p1,
    math.Point<double> p2,
  ) {
    final dx = p2.x - p1.x;
    final dy = p2.y - p1.y;

    return math.sqrt(
      dx * dx + dy * dy,
    );
  }
}