part of 'login_bloc.dart';

abstract class SignInState {}

class SignInInitialState extends SignInState {}

class SignInValidUsernameState extends SignInState {}

class SignInValidPasswordState extends SignInState {}

class SignInInvalidUsernameState extends SignInState {}

class SignInInvalidPasswordState extends SignInState {}

class SignInValidCredentialState extends SignInState {}

class SignInErrorState extends SignInState {
  final String errorMessage;
  SignInErrorState(this.errorMessage);
}

class SignInSuccess extends SignInState {}

class SignInFaliure extends SignInState {}

class SignInLoadingState extends SignInState {}
