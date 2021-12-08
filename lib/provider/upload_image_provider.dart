import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_miniproject/firebase/firebase_upload_image.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final uploadImageProvider = ChangeNotifierProvider<UploadToFirebase>((ref) {
  return UploadToFirebase();
});

class UploadToFirebase extends ChangeNotifier {
  String url =
      'https://firebasestorage.googleapis.com/v0/b/flutter-additionals.appspot.com/o/files%2FCornSiLog%20(%20Corned%20Beef%2C%20Sinangag%2C%20Itlog)%20with%20Highlands%20Gold%20Corned%20Beef%20-%20The%20Peach%20Kitchen.png?alt=media&token=4859f424-9856-42ae-8268-6d363981551e';

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
    url = urlDownload;
    notifyListeners();
  }

  Future<String> _downloadLink(Reference ref, UploadTask? task) async {
    final snapshot = await task!.whenComplete(() {});
    final link = await snapshot.ref.getDownloadURL();

    return link;
  }
}
