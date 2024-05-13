import 'package:image_picker/image_picker.dart';

Future<XFile?> pickImage(ImageSource source) async {
  XFile? file = await ImagePicker()
      .pickImage(source: source, imageQuality: 50, maxWidth: 150);
  return file;
}
