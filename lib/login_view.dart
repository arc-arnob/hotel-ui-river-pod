import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loginForm(),
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
    return TextFormField(
      obscureText: true,
      decoration: const InputDecoration(
          icon: Icon(Icons.security), hintText: 'Password'),
      validator: (value) => null,
    );
  }

  Widget _usernameField() {
    return TextFormField(
      decoration:
          const InputDecoration(icon: Icon(Icons.person), hintText: 'Username'),
      validator: (value) => null,
    );
  }

  Widget _loginButton() {
    return ElevatedButton(onPressed: () {}, child: const Text('Login'));
  }
}
