import 'package:flutter/material.dart';

/// A customizable button widget that can display either text or a custom child widget.
///
/// **Usage:**
/// - **Text Button:** Provide a `text` parameter to display simple text.
/// - **Custom Content Button:** Provide a `child` parameter to display custom widgets (e.g., an `Icon`, a `Row`, or a `Column`).
///
/// **Example with Custom Child:**
/// ```dart
/// CustomButton(
///   child: Icon(Icons.add),
///   onPressed: () {
///     // Handle button press
///   },
/// )
/// ```
class CustomButton extends StatelessWidget {
  /// Key for inner button (testing)
  final Key? buttonKey;

  /// The text to be displayed on the button. Either `text` or `child` must be provided, but not both.
  final String? text;

  /// A custom widget to be displayed inside the button. Either `child` or `text` must be provided, but not both.
  final Widget? child;

  /// Specifies whether the button is in an error state. When `true`, the
  /// button's background color changes to the error color from the theme.
  final bool isError;

  /// The callback function triggered when the button is pressed.
  /// If `null`, the button will be disabled.
  final VoidCallback? onPressed;

  /// An optional fixed width for the button. If not provided, the button
  /// will size itself based on its content.
  final double? fixedWidth;

  /// An optional fixed height for the button. If not provided, the button
  /// will size itself based on its content.
  final double? fixedHeight;

  /// Creates a [CustomButton] widget with either text or custom content.
  ///
  /// **Parameters:**
  /// - `text`: The text to display on the button.
  /// - `child`: A custom widget to display inside the button.
  /// - `onPressed`: The callback function to invoke when the button is pressed.
  /// - `isError`: If `true`, displays the button in an error state with the error color.
  /// - `fixedWidth`: An optional fixed width for the button.
  /// - `fixedHeight`: An optional fixed height for the button.
  ///
  /// **Assertion:**
  /// - Exactly one of `text` or `child` must be provided, but not both.
  const CustomButton({
    super.key,
    this.buttonKey,
    this.text,
    this.child,
    this.isError = false,
    required this.onPressed,
    this.fixedWidth,
    this.fixedHeight,
  }) : assert(
          (text == null) != (child == null),
          'Either text or child must be provided, but not both.',
        );

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final Color backgroundColor = isError ? colorScheme.error : colorScheme.primary;
    final Color textColor = colorScheme.onPrimary;

    return SizedBox(
      width: fixedWidth,
      height: fixedHeight,
      child: ElevatedButton(
        key: buttonKey,
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        child: _buildButtonContent(context),
      ),
    );
  }

  Widget _buildButtonContent(BuildContext context) {
    if (child != null) return child!;
    final style = TextStyle(color: Theme.of(context).colorScheme.onPrimary);
    return Text(text!, style: style);
  }
}
