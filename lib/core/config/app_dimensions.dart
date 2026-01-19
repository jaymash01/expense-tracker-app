import 'package:flutter/material.dart';

class AppDimensions {
  /*---------------------------
   Spacing
   ---------------------------*/
  static const double spaceXXS = 2.0;
  static const double spaceXS = 4.0;
  static const double spaceS = 8.0;
  static const double spaceM = 16.0;
  static const double spaceL = 24.0;
  static const double spaceXL = 32.0;
  static const double spaceXXL = 48.0;
  static const double spaceXXXL = 64.0;

  /*---------------------------
   Border Radius
   ---------------------------*/
  static const double radiusXS = 2.0;
  static const double radiusS = 4.0;
  static const double radiusM = 8.0;
  static const double radiusL = 12.0;
  static const double radiusXL = 16.0;
  static const double radiusXXL = 24.0;
  static const double radiusCircle = 100.0;

  /*---------------------------
   Elevation
   ---------------------------*/
  static const double elevationNone = 0.0;
  static const double elevationXS = 1.0;
  static const double elevationS = 2.0;
  static const double elevationM = 4.0;
  static const double elevationL = 8.0;
  static const double elevationXL = 16.0;

  /*---------------------------
   Opacity
   ---------------------------*/
  static const double opacityDisabled = 0.38;
  static const double opacityMedium = 0.60;
  static const double opacityHigh = 0.87;

  /*---------------------------
   Duration
   ---------------------------*/
  static const Duration durationFast = Duration(milliseconds: 150);
  static const Duration durationNormal = Duration(milliseconds: 300);
  static const Duration durationSlow = Duration(milliseconds: 450);

  /*---------------------------
   Sizes
   ---------------------------*/
  static const double iconSizeXS = 16.0;
  static const double iconSizeS = 20.0;
  static const double iconSizeM = 24.0;
  static const double iconSizeL = 32.0;
  static const double iconSizeXL = 40.0;

  static const double buttonHeightS = 36.0;
  static const double buttonHeightM = 48.0;
  static const double buttonHeightL = 56.0;

  static const double inputHeightS = 40.0;
  static const double inputHeightM = 48.0;
  static const double inputHeightL = 56.0;

  /*---------------------------
   Breakpoints
   ---------------------------*/
  static const double breakpointMobile = 600.0;
  static const double breakpointTablet = 900.0;
  static const double breakpointDesktop = 1200.0;

  /*---------------------------
   Component Dimensions
   ---------------------------*/
  static const EdgeInsets cardPadding = EdgeInsets.all(spaceM);
  static const EdgeInsets listTilePadding = EdgeInsets.symmetric(
    horizontal: spaceM,
    vertical: spaceS,
  );
  static const EdgeInsets dialogPadding = EdgeInsets.all(spaceL);
  static const EdgeInsets formFieldPadding = EdgeInsets.symmetric(
    horizontal: spaceM,
    vertical: spaceS,
  );
  static const EdgeInsets appBarPadding = EdgeInsets.symmetric(
    horizontal: spaceM,
    vertical: spaceXS,
  );

  /*---------------------------
   Shadows
   ---------------------------*/
  static List<BoxShadow> getShadowXS(Color shadowColor) => [
    BoxShadow(
      color: shadowColor.withValues(alpha: 0.05),
      blurRadius: 1,
      offset: const Offset(0, 1),
    ),
  ];

  static List<BoxShadow> getShadowS(Color shadowColor) => [
    BoxShadow(
      color: shadowColor.withValues(alpha: 0.1),
      blurRadius: 2,
      offset: const Offset(0, 1),
    ),
  ];

  static List<BoxShadow> getShadowM(Color shadowColor) => [
    BoxShadow(
      color: shadowColor.withValues(alpha: 0.1),
      blurRadius: 4,
      spreadRadius: 1,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> getShadowL(Color shadowColor) => [
    BoxShadow(
      color: shadowColor.withValues(alpha: 0.1),
      blurRadius: 8,
      spreadRadius: 2,
      offset: const Offset(0, 4),
    ),
  ];
}
