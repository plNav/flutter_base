import 'package:baccus_kitchen/utils/virtual_keyboard/button_widget.dart';
import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final Function? onPressed;
  final Widget label;
  final Color? borderColor;
  final Color? buttonColor;
  final Color? focusColor;
  final bool? autofocus;

  const Button({
    super.key,
    required this.label,
    this.onPressed,
    this.autofocus,
    this.borderColor,
    this.focusColor,
    this.buttonColor,
  });

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  FocusNode? _node;

  @override
  void initState() {
    _node = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      highlightElevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      autofocus: widget.autofocus ?? widget.autofocus!,
      fillColor: widget.buttonColor ?? widget.buttonColor,
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 0,
      focusColor: widget.focusColor ?? widget.focusColor,
      focusNode: _node,
      onPressed: () => widget.onPressed!(),
      child: ButtonWidget(label: widget.label),
    );
  }
}
