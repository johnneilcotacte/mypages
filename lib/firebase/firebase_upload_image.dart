import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class UploadFireBaseStorage {
  static Future<UploadTask?> uploadBytes(String destination, Uint8List data) {
    final ref = FirebaseStorage.instance.ref(destination);
    try {
      return Future.value(ref.putData(data));
    } catch (e) {
      return Future.value(null);
    }
  }
}
