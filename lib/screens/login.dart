import 'package:chat_app/widgets/login_form.dart';
import 'package:chat_app/widgets/register_form/register_form.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLogin = true;

  Widget getForm() {
    if (isLogin) {
      return LoginForm(onTapRegister: () {
        setState(() {
          isLogin = false;
        });
      });
    }
    return RegisterForm(goToLogin: () {
      setState(() {
        isLogin = true;
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: form,
        ),
      ),
    );
  }
}
