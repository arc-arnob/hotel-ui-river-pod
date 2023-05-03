import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, SignInState> {
  final AuthRepository authRepository;
  LoginBloc({required this.authRepository}) : super(SignInInitialState()) {
    on<LoginUsernameChanged>(_onLoginUsernameChanged);
    on<LoginPasswordChanged>(_onLoginPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  void _onLoginUsernameChanged(
      LoginUsernameChanged event, Emitter<SignInState> emit) async {
    if (event.username.length < 4) {
      emit(SignInInvalidUsernameState());
    }
    emit(SignInValidUsernameState());
  }

  void _onLoginPasswordChanged(
      LoginPasswordChanged event, Emitter<SignInState> emit) async {
    if (event.password.length < 8) {
      emit(SignInInvalidPasswordState());
    }
    emit(SignInValidPasswordState());
  }

  void _onLoginSubmitted(
      LoginSubmitted event, Emitter<SignInState> emit) async {
    if (event.username.length < 3 || event.password.length < 8) {
      emit(SignInValidCredentialState());
      return;
    }
    emit(SignInLoadingState());
    try {
      await authRepository.login();
      emit(SignInSuccess());
    } on Exception catch (err) {
      emit(SignInFaliure());
    }
  }
}
