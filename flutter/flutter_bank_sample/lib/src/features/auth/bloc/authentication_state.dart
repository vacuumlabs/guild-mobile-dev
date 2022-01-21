part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState({
    this.status = AuthenticationStatus.initial,
    this.loadingState = const Loaded(),
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.biometrics = const Biometrics(available: false, loginPresent: false),
  });

  AuthenticationState copyWith({
    AuthenticationStatus? status,
    LoadingState? loadingState,
    Username? username,
    Password? password,
    Biometrics? biometrics,
  }) {
    return AuthenticationState(
      status: status ?? this.status,
      loadingState: loadingState ?? this.loadingState,
      username: username ?? this.username,
      password: password ?? this.password,
      biometrics: biometrics ?? this.biometrics,
    );
  }

  final AuthenticationStatus status;
  final LoadingState loadingState;
  final Username username;
  final Password password;
  final Biometrics biometrics;

  @override
  List<Object> get props => [status, loadingState, username, password, biometrics];
}
