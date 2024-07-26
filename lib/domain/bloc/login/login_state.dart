part of 'login_bloc.dart';

enum LoginStatus { loaded, authSuccess, authFailed, authenticating }

final class LoginState extends Equatable {
  final LoginStatus status;

  const LoginState({this.status = LoginStatus.loaded});

  LoginState copyWith({LoginStatus? status}) {
    return LoginState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
