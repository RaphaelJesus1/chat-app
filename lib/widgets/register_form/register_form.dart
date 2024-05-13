import 'dart:io';

import 'package:chat_app/utils/pick_image.dart';
import 'package:chat_app/utils/validator.dart';
import 'package:chat_app/widgets/register_form/photo_method_drawer.dart';
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
  XFile? _profileImage;

  bool _showPassword = false;
  bool _showConfirmPassword = false;

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

  void _setProfileImage(ImageSource source) async {
    final image = await pickImage(source);
    if (image != null) {
      setState(() {
        _profileImage = image;
      });
    }
  }

  void _submit() {
    final isValid = _form.currentState!.validate();
    if (isValid) {
      _form.currentState!.save();
      widget.goToLogin();
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
    void showImageMethodModal() {
      showModalBottomSheet(
          context: context,
          builder: (ctx) => PhotoMethodDrawer(onTapCamera: () {
                _setProfileImage(ImageSource.camera);
              }, onTapGallery: () {
                _setProfileImage(ImageSource.gallery);
              }));
    }

    return Form(
      key: _form,
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: showImageMethodModal,
                child: CircleAvatar(
                  radius: 24,
                  backgroundImage: _profileImage != null
                      ? FileImage(File(_profileImage!.path))
                      : null,
                  child: _profileImage == null
                      ? const Icon(Icons.add_a_photo_outlined)
                      : null,
                ),
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
            onPressed: _submit,
            style: ElevatedButton.styleFrom(
                backgroundColor:
                    Theme.of(context).colorScheme.primaryContainer),
            child: const Text("Sign up"),
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
