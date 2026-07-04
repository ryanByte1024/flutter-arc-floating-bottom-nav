import 'package:flutter/foundation.dart';

@immutable
class FloatingBottomNavigationCurve {
  const FloatingBottomNavigationCurve({
    this.topY = 28,
    this.shoulderWidth = 28,
    this.crestWidth = 74,
    this.crestHeight = 24,
    this.topCornerRadius = 24,
    this.bottomCornerRadius = 0,
    this.slopeLift = 10,
    this.shoulderRoundness = 0.64,
    this.crestRoundness = 0.34,
  });

  /// The vertical position of the flat top baseline on both sides.
  final double topY;

 /// Width of the left and right transition zones leading into the center crest.
  ///
  /// In v0.1.0+ the bar uses a single raised-cosine bump profile.
  /// [shoulderWidth] defines the transition zone width on each side
  /// between the flat baseline and the crest peak region.
  /// The total bump width = `crestWidth + 2 * shoulderWidth`.
  final double shoulderWidth;

  /// Width of the rounded center crest.
  ///
  /// In v0.1.0+ this controls the central region width of the
  /// raised-cosine bump at half height.
  final double crestWidth;

  /// Visible height from the flat baseline up to the crest peak.
  final double crestHeight;

  /// The radius of the top-left and top-right corners of the bar background.
  final double topCornerRadius;

  /// The radius of the bottom-left and bottom-right corners of the bar background.
  final double bottomCornerRadius;

  /// Controls how rounded the left/right rise and fall are.
  /// Smaller values make the sides feel straighter.
  /// Larger values make the shoulder transition arc more obvious.
  /// Deprecated since v0.1.0 — no longer used by the raised-cosine bump profile.
  final double slopeLift;

  /// Controls how softly the side shoulders flow into the center crest.
  /// Larger values create a longer and rounder transition.
  /// Deprecated since v0.1.0 — no longer used by the raised-cosine bump profile.
  final double shoulderRoundness;

  /// Controls how full the crest apex feels.
  /// Smaller values make the top more pointed, larger values make it rounder.
  /// Deprecated since v0.1.0 — no longer used by the raised-cosine bump profile.
  final double crestRoundness;

  FloatingBottomNavigationCurve copyWith({
    double? topY,
    double? shoulderWidth,
    double? crestWidth,
    double? crestHeight,
    double? topCornerRadius,
    double? bottomCornerRadius,
    double? slopeLift,
    double? shoulderRoundness,
    double? crestRoundness,
  }) {
    return FloatingBottomNavigationCurve(
      topY: topY ?? this.topY,
      shoulderWidth: shoulderWidth ?? this.shoulderWidth,
      crestWidth: crestWidth ?? this.crestWidth,
      crestHeight: crestHeight ?? this.crestHeight,
      topCornerRadius: topCornerRadius ?? this.topCornerRadius,
      bottomCornerRadius: bottomCornerRadius ?? this.bottomCornerRadius,
      slopeLift: slopeLift ?? this.slopeLift,
      shoulderRoundness: shoulderRoundness ?? this.shoulderRoundness,
      crestRoundness: crestRoundness ?? this.crestRoundness,
    );
  }
}
