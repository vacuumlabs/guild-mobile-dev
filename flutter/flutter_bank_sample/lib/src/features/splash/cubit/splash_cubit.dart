import 'package:bloc/bloc.dart';

/// A [Cubit] which manages an [bool] as its state.
class SplashCubit extends Cubit<bool> {
  SplashCubit() : super(true);

  /// Countdown and emit state to close splash
  void startCountDown() {
    Future.delayed(const Duration(seconds: 5), () => emit(false));
  }
}
