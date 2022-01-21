import 'package:equatable/equatable.dart';

abstract class LoadingState extends Equatable {
  const LoadingState();

  @override
  List<Object> get props => [];
}

class Loaded extends LoadingState {
  const Loaded();
}

class Loading extends LoadingState {}

class Error extends LoadingState {
  const Error(this.errorMessage);

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
