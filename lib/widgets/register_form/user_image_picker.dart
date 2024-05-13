import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../utils/pick_image.dart';
import 'photo_method_drawer.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker(
      {super.key, required this.setProfileImage, required this.profileImage});

  final void Function(File image) setProfileImage;
  final File? profileImage;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  void _setImage(ImageSource source) async {
    final image = await pickImage(source);
    if (image != null) {
      widget.setProfileImage(File(image.path));
    }
  }

  void showImageMethodModal() {
    showModalBottomSheet(
        context: context,
        builder: (ctx) => PhotoMethodDrawer(onTapCamera: () {
              _setImage(ImageSource.camera);
            }, onTapGallery: () {
              _setImage(ImageSource.gallery);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: showImageMethodModal,
      child: CircleAvatar(
        radius: 24,
        backgroundImage: widget.profileImage != null
            ? FileImage(widget.profileImage!)
            : null,
        child: widget.profileImage == null
            ? const Icon(Icons.add_a_photo_outlined)
            : null,
      ),
    );
  }
}
