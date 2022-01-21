import 'package:equatable/equatable.dart';

class SavedBiometrics extends Equatable {
  const SavedBiometrics({required this.username, required this.password});

  final String username;
  final String password;

  @override
  List<Object> get props => [username, password];

  static SavedBiometrics fromJson(dynamic json) {
    return SavedBiometrics(
      username: json['username'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
  };
}