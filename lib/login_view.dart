import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotet_ui_river_pod/auth_repository.dart';
import 'package:hotet_ui_river_pod/form_submission_status.dart';

import 'controller/bloc/login_bloc.dart';

class LoginView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(authRepository: AuthRepository()),
        child: _loginForm(),
      ),
    );
  }

  Widget _loginForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _usernameField(),
              _passwordField(),
              const SizedBox(
                height: 20,
              ),
              _loginButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          obscureText: true,
          decoration: const InputDecoration(
              icon: Icon(Icons.security), hintText: 'Password'),
          validator: (value) =>
              state.isValidPassword ? null : 'Password too short',
          onChanged: (value) => dispatchPasswordChange(value, context),
        );
      },
    );
  }

  Widget _usernameField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          decoration: const InputDecoration(
              icon: Icon(Icons.person), hintText: 'Username'),
          validator: (value) =>
              state.isValidUsername ? null : 'Username too short',
          onChanged: (value) => dispatchUsernameChange(value, context),
        );
      },
    );
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    dispatchLogin(context);
                  }
                },
                child: const Text('Login'),
              );
      },
    );
  }

  void dispatchUsernameChange(value, context) {
    BlocProvider.of<LoginBloc>(context).add(LoginUsernameChanged(value));
  }

  void dispatchPasswordChange(value, context) {
    BlocProvider.of<LoginBloc>(context).add(LoginPasswordChanged(value));
  }

  void dispatchLogin(context) {
    BlocProvider.of<LoginBloc>(context).add(LoginSubmitted());
  }
}
