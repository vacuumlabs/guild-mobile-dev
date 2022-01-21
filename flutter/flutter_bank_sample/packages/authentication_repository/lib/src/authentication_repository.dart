import 'dart:async';

import 'authentication_status.dart';

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationRepoStatus>();

  Stream<AuthenticationRepoStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationUnauthorized();
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 3000),
          () => _controller.add(AuthenticationAuthorized(token: "Some token as result in this future")),
    );
  }

  void sessionExpired() => _controller.add(AuthenticationExpired());

  void dispose() => _controller.close();
}