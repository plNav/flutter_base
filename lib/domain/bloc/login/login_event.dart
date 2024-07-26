part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class InputUserEvent extends LoginEvent {
  final String username;

  const InputUserEvent({required this.username});

  @override
  List<Object?> get props => [username];
}
