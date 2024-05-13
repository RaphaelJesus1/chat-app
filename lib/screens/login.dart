import 'package:chat_app/widgets/login_form.dart';
import 'package:chat_app/widgets/register_form/register_form.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoginScreen = true;

  Widget getForm() {
    if (isLoginScreen) {
      return LoginForm(onTapRegister: () {
        setState(() {
          isLoginScreen = false;
        });
      });
    }
    return RegisterForm(goToLogin: () {
      setState(() {
        isLoginScreen = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final form = getForm();
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlutterChat 💬'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: form,
      ),
    );
  }
}
