part of 'home_bloc.dart';

enum HomeStatus { loaded, loading }

final class HomeState extends Equatable {
  final HomeStatus status;
  final User? user;

  const HomeState({
    this.status = HomeStatus.loading,
    this.user,
  });

  HomeState copyWith({
    HomeStatus? status,
    User? Function()? user,
  }) {
    return HomeState(
      status: status ?? this.status,
      user: user == null ? this.user : user(),
    );
  }

  @override
  List<Object?> get props => [status, user];
}
