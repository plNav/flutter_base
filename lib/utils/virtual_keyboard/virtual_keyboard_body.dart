import 'package:baccus_kitchen/utils/virtual_keyboard/button.dart';
import 'package:baccus_kitchen/utils/virtual_keyboard/data/loading.dart';
import 'package:baccus_kitchen/utils/virtual_keyboard/data/utils.dart';
import 'package:baccus_kitchen/utils/virtual_keyboard/virtual_keyboard_bloc/keyboard_shift/keyboard_shift_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnscreenKeyboard extends StatelessWidget {
  final ValueChanged<String?>? onChanged;
  final String? value;
  final InitialCase initialCase;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? buttonColor;
  final Color? focusColor;

  const OnscreenKeyboard({
    super.key,
    this.onChanged,
    this.backgroundColor,
    this.focusColor,
    this.borderColor,
    this.buttonColor,
    this.value,
    required this.initialCase,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => KeyboardShiftBloc(),
      child: OnscreenKeyboardWidget(
        onChanged: onChanged,
        initialCase: initialCase,
        value: value,
        borderColor: borderColor,
        backgroundColor: backgroundColor,
        buttonColor: buttonColor,
        focusColor: focusColor,
      ),
    );
  }
}

class OnscreenKeyboardWidget extends StatefulWidget {
  final ValueChanged<String?>? onChanged;
  final InitialCase? initialCase;
  final String? value;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? buttonColor;
  final Color? focusColor;

  const OnscreenKeyboardWidget({
    super.key,
    this.onChanged,
    this.backgroundColor,
    this.focusColor,
    this.borderColor,
    this.buttonColor,
    this.value,
    this.initialCase,
  });

  @override
  State<OnscreenKeyboardWidget> createState() => _OnscreenKeyboardWidgetState();
}

class _OnscreenKeyboardWidgetState extends State<OnscreenKeyboardWidget> {
  String? _text = '';
  late KeyboardShiftBloc _keyBloc;

  @override
  void initState() {
    super.initState();
    if (widget.value != null) {
      _text = widget.value;
    }
    _keyBloc = context.read<KeyboardShiftBloc>();
  }

  void specialCharacters() {
    if (_keyBloc.state is KeyboardShiftSymbols) {
      _keyBloc.add(const KeyboardShiftUpperCaseEvent());
    } else {
      _keyBloc.add(const KeyboardShiftSymbolsEvent());
    }
  }

  void shift() {
    if (_keyBloc.state is KeyboardShiftUpperCase) {
      _keyBloc.add(const KeyboardShiftLowerCaseEvent());
    } else if (_keyBloc.state is KeyboardShiftLowerCase) {
      _keyBloc.add(const KeyboardShiftUpperCaseEvent());
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    switch (widget.initialCase) {
      case InitialCase.upperCase:
        _keyBloc.add(const KeyboardShiftUpperCaseEvent());
        break;
      case InitialCase.lowerCase:
        _keyBloc.add(const KeyboardShiftLowerCaseEvent());
        break;
      case InitialCase.sentenceCase:
        _keyBloc.add(const KeyboardShiftUpperCaseEvent());
        break;
      case InitialCase.numeric:
        _keyBloc.add(const KeyboardShiftSymbolsEvent());
        break;
      default:
        _keyBloc.add(const KeyboardShiftUpperCaseEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    final translator = AppLocalizations.of(context)!;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: Container(
                  color: widget.backgroundColor ?? Colors.transparent,
                  child: BlocBuilder<KeyboardShiftBloc, KeyboardShiftState>(
                    builder: (context, state) {
                      if (state is KeyboardShiftLowerCase) {
                        return _buildBody(state.lowerCase);
                      } else if (state is KeyboardShiftUpperCase) {
                        return _buildBody(state.upperCase);
                      } else if (state is KeyboardShiftLoading) {
                        return _buildBody(state.loading);
                      } else if (state is KeyboardShiftSymbols) {
                        return _buildBody(state.symbols);
                      } else {
                        return _buildBody(loading);
                      }
                    },
                  ),
                ),
              ),
              Container(
                color: widget.backgroundColor ?? Colors.transparent,
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Button(
                        autofocus: false,
                        focusColor: widget.focusColor ?? widget.focusColor,
                        borderColor: widget.borderColor ?? widget.borderColor,
                        buttonColor: widget.buttonColor ?? widget.buttonColor,
                        onPressed: () => shift(),
                        label: const Icon(Icons.arrow_upward),
                      ),
                    ),
                    Flexible(
                      child: Button(
                        autofocus: false,
                        focusColor: widget.focusColor ?? widget.focusColor,
                        borderColor: widget.borderColor ?? widget.borderColor,
                        buttonColor: widget.buttonColor ?? widget.buttonColor,
                        onPressed: () {
                          _text = '';
                          setState(() {});
                          widget.onChanged!(_text);
                        },
                        label: const Text(
                          'Borrar Todo', // TODO: TRANSLATE
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Button(
                        autofocus: true,
                        focusColor: widget.focusColor ?? widget.focusColor,
                        borderColor: widget.borderColor ?? widget.borderColor,
                        buttonColor: widget.buttonColor ?? widget.buttonColor,
                        onPressed: () {
                          _text = '$_text ';
                          setState(() {});
                          widget.onChanged!(_text);
                        },
                        label: const Icon(Icons.space_bar, size: 35),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Button(
                autofocus: false,
                focusColor: widget.focusColor ?? widget.focusColor,
                borderColor: widget.borderColor ?? widget.borderColor,
                buttonColor: widget.buttonColor ?? widget.buttonColor,
                onPressed: () {
                  if (_text!.isNotEmpty) {
                    _text = _text!.substring(0, _text!.length - 1);
                  }
                  setState(() {});
                  widget.onChanged!(_text);
                },
                label: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.backspace,
                    size: 20,
                  ),
                ),
              ),
            ),
            Button(
              autofocus: false,
              focusColor: widget.focusColor ?? widget.focusColor,
              borderColor: widget.borderColor ?? widget.borderColor,
              buttonColor: widget.buttonColor ?? widget.buttonColor,
              onPressed: () {
                specialCharacters();
              },
              label: BlocBuilder<KeyboardShiftBloc, KeyboardShiftState>(
                builder: (context, state) {
                  if (state is KeyboardShiftSymbols) {
                    return const Text(
                      'ABC',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    );
                  } else {
                    return const Text(
                      '&123',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBody(List<String> labels) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: labels.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 10),
      itemBuilder: (context, index) => Button(
        autofocus: false,
        focusColor: widget.focusColor ?? widget.focusColor,
        borderColor: widget.borderColor ?? widget.borderColor,
        buttonColor: widget.buttonColor ?? widget.buttonColor,
        label: Text(
          labels[index],
          style: const TextStyle(fontSize: 25),
        ),
        onPressed: () {
          _text = _text! + labels[index];
          setState(() {});
          widget.onChanged!(_text);
        },
      ),
    );
  }
}
