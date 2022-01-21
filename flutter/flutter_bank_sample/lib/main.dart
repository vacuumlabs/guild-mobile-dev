import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';

import 'app.dart';

void main() {
  // wrapping in MaterialApp so we can use [MediaQuery.of] on BuildContext
  runApp(MaterialApp(
      home: MyApp(
    authenticationRepository: AuthenticationRepository(),
  )));
}
