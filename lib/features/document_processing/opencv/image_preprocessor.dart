import 'package:opencv_dart/opencv.dart' as cv;

/// Converts an input image into an edge map suitable
/// for document contour detection.
///
/// Returned Mat must be disposed by the caller.
class ImagePreprocessor {
  const ImagePreprocessor();

  cv.Mat preprocess(cv.Mat image) {
    final gray = cv.cvtColor(
      image,
      cv.COLOR_BGR2GRAY,
    );

    final blurred = cv.gaussianBlur(
      gray,
      (5, 5),
      0,
    );

    gray.dispose();

    final edges = cv.canny(
      blurred,
      75,
      200,
    );

    blurred.dispose();

    return edges;
  }
}