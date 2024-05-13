import 'dart:io';

import 'package:chat_app/utils/pick_image.dart';
import 'package:chat_app/widgets/register_form/photo_method_drawer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm({super.key, required this.goToLogin});

  void Function() goToLogin;

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
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

  void _createAccount() {
    widget.goToLogin();
  }

  void _setProfileImage(ImageSource source) async {
    final image = await pickImage(source);
    if (image != null) {
      setState(() {
        _profileImage = image;
      });
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
    void _showImageMethodModal() {
      showModalBottomSheet(
          context: context,
          builder: (ctx) => PhotoMethodDrawer(onTapCamera: () {
                _setProfileImage(ImageSource.camera);
              }, onTapGallery: () {
                _setProfileImage(ImageSource.gallery);
              }));
    }

    return Form(
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: _showImageMethodModal,
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
                  decoration: const InputDecoration(label: Text("Name")),
                ),
              ),
            ],
          ),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.mail_outline), label: Text("E-mail")),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _passwordController,
            obscureText: !_showPassword,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_outline),
                label: const Text("Password"),
                suffixIcon: IconButton(
                    onPressed: _togglePasswordVisibility,
                    icon: _getVisibilityIcon(_showPassword))),
          ),
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: !_showConfirmPassword,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_outline),
                label: const Text("Confirm password"),
                suffixIcon: IconButton(
                    onPressed: _toggleConfirmVisibility,
                    icon: _getVisibilityIcon(_showConfirmPassword))),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () {
                  widget.goToLogin();
                },
                child: const Text("Cancel"),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _createAccount,
                child: const Text("Create"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
