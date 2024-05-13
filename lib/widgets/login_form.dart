import 'package:chat_app/utils/firebase.dart';
import 'package:chat_app/utils/validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key, required this.onTapRegister});

  final void Function() onTapRegister;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _form = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _showPassword = false;

  Future<bool> _sendToBackend() async {
    try {
      await auth.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? "Authentication failed")));
      return false;
    }
    return true;
  }

  void _submit() async {
    final isValid = _form.currentState!.validate();
    if (isValid) {
      _form.currentState!.save();
      await _sendToBackend();
    }
  }

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
      key: _form,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            validator: Validator.email,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.mail_outline), labelText: "E-mail"),
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            textCapitalization: TextCapitalization.none,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _passwordController,
            validator: Validator.password,
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
            onPressed: _submit,
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
