
abstract class AuthenticationRepoStatus {
  const AuthenticationRepoStatus();
}

class AuthenticationUnauthorized extends AuthenticationRepoStatus {}

class AuthenticationAuthorized extends AuthenticationRepoStatus {
  AuthenticationAuthorized({required this.token});
  final String token;
}

class AuthenticationExpired extends AuthenticationRepoStatus {}
