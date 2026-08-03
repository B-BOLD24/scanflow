import 'dart:math';

/// Orders four document corners into a consistent order:
///
/// 0 -> Top Left
/// 1 -> Top Right
/// 2 -> Bottom Right
/// 3 -> Bottom Left
///
/// This ordering is required before perspective correction.
class CornerOrdering {
  const CornerOrdering();

  List<Point<double>> order(
    List<Point<double>> points,
  ) {
    if (points.length != 4) {
      throw ArgumentError(
        'Exactly 4 points are required.',
      );
    }

    final sorted = List<Point<double>>.from(points);

    // Sort by Y coordinate.
    sorted.sort(
      (a, b) => a.y.compareTo(b.y),
    );

    final top = sorted.take(2).toList();
    final bottom = sorted.skip(2).toList();

    // Sort top row left → right.
    top.sort(
      (a, b) => a.x.compareTo(b.x),
    );

    // Sort bottom row left → right.
    bottom.sort(
      (a, b) => a.x.compareTo(b.x),
    );

    return [
      top[0],     // Top Left
      top[1],     // Top Right
      bottom[1],  // Bottom Right
      bottom[0],  // Bottom Left
    ];
  }
}