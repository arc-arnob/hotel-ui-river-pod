import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotet_ui_river_pod/auth_repository.dart';

import 'controller/bloc/login_bloc.dart';

class LoginView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  LoginView({super.key});
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
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
    return BlocBuilder<LoginBloc, SignInState>(
      builder: (context, state) {
        return TextFormField(
          controller: passwordController,
          obscureText: true,
          decoration: const InputDecoration(
              icon: Icon(Icons.security), hintText: 'Password'),
          onChanged: (value) => dispatchPasswordChange(value, context),
        );
      },
    );
  }

  Widget _usernameField() {
    return BlocBuilder<LoginBloc, SignInState>(
      builder: (context, state) {
        return TextFormField(
          controller: usernameController,
          decoration: const InputDecoration(
              icon: Icon(Icons.person), hintText: 'Username'),
          onChanged: (value) => dispatchUsernameChange(value, context),
        );
      },
    );
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, SignInState>(
      builder: (context, state) {
        return state is SignInLoadingState
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () {
                  dispatchLogin(context);
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
    BlocProvider.of<LoginBloc>(context)
        .add(LoginSubmitted(usernameController.text, passwordController.text));
  }
}
