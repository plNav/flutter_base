import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'test_event.dart';
part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  TestBloc() : super(TestInitial()) {
    on<TestEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
