part of 'login_bloc.dart';

enum LoginStatus { loaded, authSuccess, authFailed, authenticating }

final class LoginState extends Equatable {
  final LoginStatus status;
  final CustomException? error;

  const LoginState({
    this.status = LoginStatus.loaded,
    this.error,
  });

  LoginState copyWith({
    LoginStatus? status,
    CustomException? Function()? error,
  }) {
    return LoginState(
      status: status ?? this.status,
      error: error == null ? this.error : error(),
    );
  }

  @override
  List<Object?> get props => [status, error];
}
