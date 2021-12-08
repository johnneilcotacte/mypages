import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_miniproject/firebase/firebase_upload_image.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final uploadImageProvider = Provider<UploadToFirebase>((ref) {
  return UploadToFirebase();
});

class UploadToFirebase {
  Future<void> uploadFile(
      {required FilePickerResult? file, required Uint8List? image}) async {
    UploadTask? task;
    if (file == null) {
      return;
    }

    final fileName = file.names.first.toString();
    final destination = 'files/$fileName';

    task = await UploadFireBaseStorage.uploadBytes(destination, image!);

    if (task == null) {
      return;
    }
    final urlDownload = await _downloadLink(task.snapshot.ref, task);
    print('Download-Link: $urlDownload');
  }

  Future<String> _downloadLink(Reference ref, UploadTask? task) async {
    final snapshot = await task!.whenComplete(() {});
    final link = await snapshot.ref.getDownloadURL();
    return link;
  }
}
