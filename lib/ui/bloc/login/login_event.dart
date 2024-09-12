part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class InputUserEvent extends LoginEvent {
  final User user;

  const InputUserEvent({required this.user});

  @override
  List<Object?> get props => [user];
}

class ConfirmErrorEvent extends LoginEvent {}
