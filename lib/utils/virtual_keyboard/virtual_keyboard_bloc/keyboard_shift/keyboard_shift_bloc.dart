
import 'package:baccus_kitchen/utils/virtual_keyboard/data/upper_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baccus_kitchen/utils/virtual_keyboard/data/loading.dart';
import 'package:baccus_kitchen/utils/virtual_keyboard/data/lower_case.dart';
import 'package:baccus_kitchen/utils/virtual_keyboard/data/symbols.dart';

part 'keyboard_shift_event.dart';
part 'keyboard_shift_state.dart';

class KeyboardShiftBloc extends Bloc<KeyboardShiftEvent, KeyboardShiftState> {
  KeyboardShiftBloc() : super(const KeyboardShiftInitial()) {
    on((event, emit) => (emit(const KeyboardShiftLoading(loading))));

    on<KeyboardShiftUpperCaseEvent>((event, emit) {
      //
      emit(const KeyboardShiftUpperCase(upperCase));
    });
    on<KeyboardShiftSymbolsEvent>((event, emit) {
      //
      emit(const KeyboardShiftSymbols(symbols));
    });
    on<KeyboardShiftLowerCaseEvent>((event, emit) {
      //
      emit(const KeyboardShiftLowerCase(lowerCase));
    });
  }
}
