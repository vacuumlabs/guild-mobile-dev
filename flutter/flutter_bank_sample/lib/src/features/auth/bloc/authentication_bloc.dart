import 'package:authentication_repository/authentication_repository.dart';
import 'package:biometric_storage/biometric_storage.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bank_sample/loading_state.dart';
import 'package:flutter_bank_sample/src/features/auth/models/biometrics.dart';
import 'package:flutter_bank_sample/src/features/auth/models/models.dart';
import 'package:flutter_bank_sample/src/features/auth/models/saved_biometrics.dart';
import 'package:formz/formz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

part 'authentication_event.dart';
part 'authentication_state.dart';

enum AuthenticationStatus {
  initial,
  username,
  password,
  offerBiometrics,
  passed,
}

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  static const _biometricsPreferenceKey = "pref_key_biometrics";
  static const _biometricsStorageKey = "biometrics";

  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const AuthenticationState()) {
    on<AuthenticationNextStepRequested>((event, emit) async {
      await _onNextStep(event, emit);
    });
    on<AuthenticationPreviousStepRequested>((event, emit) {
      _onPreviousStep(event, emit);
    });
    on<AuthenticationUserNameChanged>((event, emit) {
      _onUsernameChange(event, emit);
    });
    on<AuthenticationPasswordChanged>((event, emit) {
      _onPasswordChange(event, emit);
    });
    on<AuthenticationLoadBiometrics>((event, emit) async {
      await _loadBiometrics(event, emit);
    });
    on<AuthenticationSkipBiometrics>((event, emit) {
      _skipBiometricsOffer(event, emit);
    });
    on<AuthenticationSaveBiometrics>((event, emit) async {
      await _saveBiometrics(event, emit);
    });
    on<AuthenticationBiometricLogin>((event, emit) async {
      await _loginWithBiometrics(event, emit);
    });
  }

  final AuthenticationRepository _authenticationRepository;

  Future<void> _onNextStep(
    AuthenticationNextStepRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    switch (state.status) {
      case AuthenticationStatus.initial:
        emit(state.copyWith(
          status: AuthenticationStatus.username,
          username: const Username.pure(),
        ));
        break;
      case AuthenticationStatus.username:
        {
          // if username is invalid, block transition to next step
          var newState = state.copyWith(username: Username.dirty(state.username.value));
          if (Formz.validate([newState.username]) == FormzStatus.invalid) {
            emit(newState);
            return;
          }
          emit(state.copyWith(
            status: AuthenticationStatus.password,
            password: const Password.pure(),
          ));
          break;
        }
      case AuthenticationStatus.password:
        {
          // if password is invalid, block transition to next step
          var newState = state.copyWith(password: Password.dirty(state.password.value));
          if (Formz.validate([newState.password]) == FormzStatus.invalid) {
            emit(newState);
            return;
          }
          await _onPasswordSubmitted(emit); return;
        }
      case AuthenticationStatus.offerBiometrics:
        return; // no next from offerBiometrics state
      case AuthenticationStatus.passed:
        return; // no next from passed state
    }
  }

  void _onPreviousStep(
    AuthenticationPreviousStepRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    late AuthenticationStatus newStatus;
    switch (state.status) {
      case AuthenticationStatus.initial:
        newStatus = AuthenticationStatus.initial;
        break;
      case AuthenticationStatus.username:
        newStatus = AuthenticationStatus.initial;
        break;
      case AuthenticationStatus.password:
        newStatus = AuthenticationStatus.username;
        break;
      case AuthenticationStatus.offerBiometrics:
        newStatus = AuthenticationStatus.passed;
        break;
      case AuthenticationStatus.passed:
        return; // no back from passed state
    }
    emit(state.copyWith(
      status: newStatus,
    ));
  }

  void _onUsernameChange(
    AuthenticationUserNameChanged event,
    Emitter<AuthenticationState> emit,
  ) {
    emit(state.copyWith(username: Username.dirty(event.username)));
  }

  void _onPasswordChange(
    AuthenticationPasswordChanged event,
    Emitter<AuthenticationState> emit,
  ) {
    emit(state.copyWith(password: Password.dirty(event.password)));
  }

  Future<void> _onPasswordSubmitted(
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(loadingState: Loading()));
    try {
      await _authenticationRepository.logIn(
        username: state.username.value,
        password: state.password.value,
      );
      if (state.biometrics.available) {
        emit(state.copyWith(
          status: AuthenticationStatus.offerBiometrics,
          loadingState: const Loaded(),
        ));
      } else {
        emit(state.copyWith(
          status: AuthenticationStatus.passed,
          loadingState: const Loaded(),
        ));
      }
    } catch (error) {
      emit(state.copyWith(loadingState: Error(error.toString())));
    }
  }

  Future<void> _loadBiometrics(AuthenticationLoadBiometrics event, Emitter<AuthenticationState> emit) async {
    final response = await BiometricStorage().canAuthenticate();
    if (response != CanAuthenticateResponse.success) {
      emit(state.copyWith(biometrics: const Biometrics(available: false, loginPresent: false)));
      return;
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var value = sharedPreferences.getBool(_biometricsPreferenceKey) ?? false;
    emit(state.copyWith(biometrics: Biometrics(available: true, loginPresent: value)));
  }

  void _skipBiometricsOffer(AuthenticationSkipBiometrics event, Emitter<AuthenticationState> emit) {
    emit(state.copyWith(
      status: AuthenticationStatus.passed,
      loadingState: const Loaded(),
    ));
  }

  Future<void> _saveBiometrics(AuthenticationSaveBiometrics event, Emitter<AuthenticationState> emit) async {
    final storageFile = await BiometricStorage().getStorage(_biometricsStorageKey);
    try {
      var encoded = json.encode(SavedBiometrics(username: state.username.value, password: state.password.value).toJson());
      storageFile.write(encoded);
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setBool(_biometricsPreferenceKey, true);
      emit(state.copyWith(
        status: AuthenticationStatus.passed,
      ));
    } catch (e) {
      // catch errors, but stay on same screen
      e.toString();
    }
  }

  Future<void> _loginWithBiometrics(AuthenticationBiometricLogin event, Emitter<AuthenticationState> emit) async {
    emit(state.copyWith(loadingState: Loading()));
    final storageFile = await BiometricStorage().getStorage(_biometricsStorageKey);
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var rawData = await storageFile.read();
      if (rawData == null) {
        // can not extract biometrics -> hide button
        emit(state.copyWith(biometrics: const Biometrics(available: true, loginPresent: false)));
        sharedPreferences.setBool(_biometricsPreferenceKey, false);
        return;
      }
      var decoded = SavedBiometrics.fromJson(json.decode(rawData));
      await _authenticationRepository.logIn(
        username: decoded.username,
        password: decoded.password,
      );

      emit(state.copyWith(
        status: AuthenticationStatus.passed,
        loadingState: const Loaded(),
      ));
    } catch (error) {
      // catch errors, but stay on same screen
      emit(state.copyWith(loadingState: Error(error.toString())));
    }
  }
}
