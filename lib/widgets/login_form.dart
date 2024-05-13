import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key, required this.onTapRegister});

  final void Function() onTapRegister;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _showPassword = false;

  void _login() {}

  void _togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.mail_outline), labelText: "E-mail"),
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            textCapitalization: TextCapitalization.none,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _passwordController,
            obscureText: !_showPassword,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_outline),
                labelText: "Password",
                suffixIcon: IconButton(
                    onPressed: _togglePasswordVisibility,
                    icon: Icon(_showPassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined))),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _login,
            style: ElevatedButton.styleFrom(
                backgroundColor:
                    Theme.of(context).colorScheme.primaryContainer),
            child: const Text("Log in"),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: widget.onTapRegister,
            child: const Text("Create an account"),
          )
        ],
      ),
    );
  }
}
