import 'package:equatable/equatable.dart';

class Biometrics extends Equatable {
  const Biometrics({required this.available, required this.loginPresent});

  final bool available;
  final bool loginPresent;

  @override
  List<Object> get props => [available, loginPresent];
}