import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_miniproject/firebase/firebase_upload_image.dart';
import 'package:flutter_miniproject/model/user.dart';
import 'package:flutter_miniproject/provider/current_user_provider.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

final uploadImageProvider = ChangeNotifierProvider<UploadToFirebase>((ref) {
  // final user = ref.watch(currentUserProvider).user;
  return UploadToFirebase();
});

class UploadToFirebase extends ChangeNotifier {
  //User? user;
  //UploadToFirebase({required this.user});

  String url =
      'https://firebasestorage.googleapis.com/v0/b/flutter-additionals.appspot.com/o/files%2FCornSiLog%20(%20Corned%20Beef%2C%20Sinangag%2C%20Itlog)%20with%20Highlands%20Gold%20Corned%20Beef%20-%20The%20Peach%20Kitchen.png?alt=media&token=4859f424-9856-42ae-8268-6d363981551e';

  Future<String?> uploadFile(
      {required FilePickerResult? file,
      required Uint8List? image,
      required String user_id}) async {
    UploadTask? task;
    if (file == null) {
      return url = '';
    }

    final fileName = file.names.first.toString();
    final destination = user_id + '/' + fileName;

    task = await UploadFireBaseStorage.uploadBytes(destination, image!);

    if (task == null) {
      return url = '';
    }
    final urlDownload = await _downloadLink(task.snapshot.ref, task);
    // print('Download-Link: $urlDownload');
    return urlDownload;
    // notifyListeners();
  }

  Future<String> _downloadLink(Reference ref, UploadTask? task) async {
    final snapshot = await task!.whenComplete(() {});
    final link = await snapshot.ref.getDownloadURL();

    return link;
  }
}
