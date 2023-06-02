import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageService {
  final storageRef = FirebaseStorage.instance.ref();

  Future<List<String>?> uploudImages(List<XFile> images) async {
    if (images.isNotEmpty) {
      List<String> downloadUrls = [];
      for (var i in images) {
        final mountainsRef =
            storageRef.child("images/${DateTime.now().day}/${i.name}");
        try {
          final file = File(i.path);
          final upLoadTask = await mountainsRef.putFile(file);

          final downloadUrl = await upLoadTask.ref.getDownloadURL();
          downloadUrls.add(downloadUrl);

          print('Download URL: $downloadUrl');

          print(upLoadTask.metadata?.fullPath);
        } catch (e) {
          log(e.toString());
        }
      }
      return downloadUrls;
    } else {
      return null;
    }
  }
}
