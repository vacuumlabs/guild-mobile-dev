part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationPreviousStepRequested extends AuthenticationEvent {
  const AuthenticationPreviousStepRequested();
}

class AuthenticationNextStepRequested extends AuthenticationEvent {
  const AuthenticationNextStepRequested();
}

class AuthenticationUserNameChanged extends AuthenticationEvent {
  const AuthenticationUserNameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

class AuthenticationPasswordChanged extends AuthenticationEvent {
  const AuthenticationPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class AuthenticationLoadBiometrics extends AuthenticationEvent {
  const AuthenticationLoadBiometrics();
}

class AuthenticationSkipBiometrics extends AuthenticationEvent {
  const AuthenticationSkipBiometrics();
}

class AuthenticationSaveBiometrics extends AuthenticationEvent {
  const AuthenticationSaveBiometrics();
}

class AuthenticationBiometricLogin extends AuthenticationEvent {
  const AuthenticationBiometricLogin();
}
