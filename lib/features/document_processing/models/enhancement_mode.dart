/// Available document enhancement modes.
///
/// These modes determine how the scanned document is processed
/// after perspective correction.
enum EnhancementMode {
  /// Returns the corrected image without any enhancement.
  original,

  /// Enhances brightness and contrast while preserving colors.
  color,

  /// Produces a high-contrast black & white document.
  blackAndWhite,
}