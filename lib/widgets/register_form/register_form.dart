import 'dart:io';

import 'package:chat_app/utils/firebase.dart';
import 'package:chat_app/utils/pick_image.dart';
import 'package:chat_app/utils/validator.dart';
import 'package:chat_app/widgets/register_form/user_image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key, required this.goToLogin});

  final void Function() goToLogin;

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _form = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  File? _profileImage;

  bool _showPassword = false;
  bool _showConfirmPassword = false;
  bool _isUploading = false;

  void _togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _toggleConfirmVisibility() {
    setState(() {
      _showConfirmPassword = !_showConfirmPassword;
    });
  }

  Icon _getVisibilityIcon(bool show) {
    return Icon(
        show ? Icons.visibility_outlined : Icons.visibility_off_outlined);
  }

  void _setProfileImage(File image) async {
    setState(() {
      _profileImage = image;
    });
  }

  Future<bool> _sendToBackend() async {
    try {
      final userCredentials = await auth.createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);

      final storageRef = storage
          .ref()
          .child("user_images")
          .child("${userCredentials.user!.uid}.jpg");
      await storageRef.putFile(_profileImage!);
      final imageUrl = await storageRef.getDownloadURL();

      await database.collection("users").doc(userCredentials.user!.uid).set({
        "username": _nameController.text,
        "email": _emailController.text,
        "profile_url": imageUrl,
      });
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
    if (isValid && _profileImage != null) {
      _form.currentState!.save();
      setState(() {
        _isUploading = true;
      });
      final success = await _sendToBackend();
      setState(() {
        _isUploading = false;
      });
      if (success) {
        widget.goToLogin();
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Column(
        children: [
          Row(
            children: [
              UserImagePicker(
                profileImage: _profileImage,
                setProfileImage: _setProfileImage,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: _nameController,
                  validator: Validator.name,
                  decoration: const InputDecoration(labelText: "Name"),
                ),
              ),
            ],
          ),
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
                    icon: _getVisibilityIcon(_showPassword))),
          ),
          TextFormField(
            controller: _confirmPasswordController,
            validator: (value) =>
                Validator.confirmPassword(value, _passwordController.text),
            obscureText: !_showConfirmPassword,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_outline),
                labelText: "Confirm password",
                suffixIcon: IconButton(
                    onPressed: _toggleConfirmVisibility,
                    icon: _getVisibilityIcon(_showConfirmPassword))),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _isUploading ? null : _submit,
            style: ElevatedButton.styleFrom(
                backgroundColor:
                    Theme.of(context).colorScheme.primaryContainer),
            child: _isUploading
                ? const SizedBox(
                    height: 16, width: 16, child: CircularProgressIndicator())
                : const Text("Sign up"),
          ),
          const SizedBox(height: 4),
          TextButton(
            onPressed: () {
              widget.goToLogin();
            },
            child: const Text("I already have an account"),
          ),
        ],
      ),
    );
  }
}
