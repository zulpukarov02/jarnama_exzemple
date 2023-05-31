import 'package:image_picker/image_picker.dart';

class ImagePicerServic {
  final ImagePicker picker = ImagePicker();
  Future<List<XFile>?> pickImage() async {
    final images = await picker.pickMultiImage(
      imageQuality: 5,
    );
    return images;
  }
}
