import 'package:flutter/material.dart';

import '../../data/enum/responsive_layout_font.dart';
import '../../data/enum/responsive_layout_size.dart';
import '../../main.dart';

/// A responsive layout widget that adapts to different screen widths, making it suitable
/// for mobile, tablet, and desktop views. It also provides helper methods to retrieve
/// responsive values for text styles, padding, and custom measurements.
/// ### Static Methods: All require BuildContext
/// - RLayoutSize `getLayoutName`
/// - TextStyle `rStyle` (RLayoutFont type)
/// - double `rDouble` (mobile, tablet? and desktop?)
/// - EdgeInsets `rPadding` (mobile, tablet? and desktop?)
class RLayout extends StatelessWidget {
  /// Constructor to define the widget for different screen sizes.
  /// - `mobile`: Required. Widget displayed on mobile screen sizes [Default].
  /// - `tablet`: Optional. If not provided, it defaults to the mobile widget.
  /// - `desktop`: Optional. If not provided, it defaults to the tablet widget.
  const RLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  Widget get _tablet => tablet ?? mobile;

  Widget get _desktop => desktop ?? _tablet;

  /// Builds the widget for the appropriate layout size. Depending on the screen width,
  /// this returns the `mobile`, `tablet`, or `desktop` widget. [Default] **mobile**
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    if (size.width < mobileWidthBreak) {
      return mobile;
    }
    if (size.width < tabletWidthBreak) {
      return _tablet;
    }
    return _desktop;
  }

  /// Determines the layout size (`mobile`, `tablet`, or `desktop`) based on the current screen width.
  static RLayoutSize getLayoutName(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    if (size.width < mobileWidthBreak) {
      return RLayoutSize.mobile;
    }
    if (size.width < tabletWidthBreak) {
      return RLayoutSize.tablet;
    }
    return RLayoutSize.desktop;
  }

  /// Returns a `TextStyle` based on the current layout size and specified font type.
  /// - `type`: Specifies the desired font size type (`large`, `medium`, `small`).
  static TextStyle rStyle({
    required BuildContext context,
    required RLayoutFont type,
  }) {
    final layout = getLayoutName(context);
    final fontTheme = Theme.of(context).textTheme;

    if (type == RLayoutFont.large) {
      switch (layout) {
        case RLayoutSize.desktop:
          return fontTheme.headlineLarge!;
        case RLayoutSize.tablet:
          return fontTheme.titleLarge!;
        case RLayoutSize.mobile:
          return fontTheme.bodyLarge!;
      }
    }

    if (type == RLayoutFont.medium) {
      switch (layout) {
        case RLayoutSize.desktop:
          return fontTheme.headlineMedium!;
        case RLayoutSize.tablet:
          return fontTheme.titleMedium!;
        case RLayoutSize.mobile:
          return fontTheme.bodyMedium!;
      }
    }

    if (type == RLayoutFont.small) {
      switch (layout) {
        case RLayoutSize.desktop:
          return fontTheme.headlineSmall!;
        case RLayoutSize.tablet:
          return fontTheme.titleSmall!;
        case RLayoutSize.mobile:
          return fontTheme.bodySmall!;
      }
    }

    throw Exception('Unsupported RLayoutFont type');
  }

  /// Returns a double value (e.g., size, width, or margin) based on the context size.
  /// - `mobileMeasure`: Value for mobile [Default].
  /// - `tabletMeasure`: If **null** `mobileMeasure`.
  /// - `desktopMeasure`: If **null** `tabletMeasure`.
  static double rDouble({
    required BuildContext context,
    required double mobileMeasure,
    double? tabletMeasure,
    double? desktopMeasure,
  }) {
    final layout = getLayoutName(context);

    switch (layout) {
      case RLayoutSize.desktop:
        return desktopMeasure ?? tabletMeasure ?? mobileMeasure;
      case RLayoutSize.tablet:
        return tabletMeasure ?? mobileMeasure;
      case RLayoutSize.mobile:
        return mobileMeasure;
    }
  }

  /// Returns padding values based on the context size.
  /// - `mobilePadding`: Padding for mobile [Default].
  /// - `tabletPadding`: If **null** `mobilePadding`
  /// - `desktopPadding`: If **null** `tabletPadding`
  static EdgeInsets rPadding({
    required BuildContext context,
    required EdgeInsets mobilePadding,
    EdgeInsets? tabletPadding,
    EdgeInsets? desktopPadding,
  }) {
    final layout = getLayoutName(context);

    switch (layout) {
      case RLayoutSize.desktop:
        return desktopPadding ?? tabletPadding ?? mobilePadding;
      case RLayoutSize.tablet:
        return tabletPadding ?? mobilePadding;
      case RLayoutSize.mobile:
        return mobilePadding;
    }
  }
}
