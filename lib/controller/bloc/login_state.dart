part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String username;
  bool get isValidUsername => username.length > 3;
  final String password;
  bool get validPassword => password.length > 6;

  final FormSubmissionStatus formStatus;
  const LoginState({
    this.username = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
  });

  LoginState copyWith({
    String? username,
    String? password,
    FormSubmissionStatus? formStatus,
  }) {
    return LoginState(
        username: this.username,
        password: this.password,
        formStatus: this.formStatus);
  }

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}
