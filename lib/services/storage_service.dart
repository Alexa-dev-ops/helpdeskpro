// ignore_for_file: avoid_print

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Upload an image to Firebase Storage
  Future<String> uploadImage(String filePath, String fileName) async {
    File file = File(filePath);
    try {
      // Upload the file
      TaskSnapshot snapshot =
          await _storage.ref('uploads/$fileName').putFile(file);
      // Get the download URL
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl; // Return the download URL
    } catch (e) {
      // Handle any errors
      print("Error uploading image: $e");
      return '';
    }
  }

  // Delete an image from Firebase Storage
  Future<void> deleteImage(String imageUrl) async {
    try {
      await _storage.refFromURL(imageUrl).delete();
    } catch (e) {
      // Handle any errors
      print("Error deleting image: $e");
    }
  }
}
