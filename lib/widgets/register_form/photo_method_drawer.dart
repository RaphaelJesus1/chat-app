import 'package:flutter/material.dart';

class PhotoMethodDrawer extends StatelessWidget {
  final void Function() onTapCamera;
  final void Function() onTapGallery;

  const PhotoMethodDrawer(
      {super.key, required this.onTapCamera, required this.onTapGallery});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Photo from...",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            ListTile(
                title: const Text("Camera"),
                onTap: () {
                  onTapCamera();
                  Navigator.of(context).pop();
                }),
            ListTile(
                title: const Text("Gallery"),
                onTap: () {
                  onTapGallery();
                  Navigator.of(context).pop();
                }),
          ],
        ),
      ),
    );
  }
}
