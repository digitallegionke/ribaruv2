import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageService {
  final ImagePicker _picker = ImagePicker();

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      return result.isGranted;
    }
  }

  Future<String?> pickAndSaveImage({
    required String directory,
    required String prefix,
    ImageSource source = ImageSource.gallery,
    int maxWidth = 800,
    int maxHeight = 800,
    int quality = 85,
  }) async {
    try {
      // Request permissions
      if (source == ImageSource.camera) {
        if (!await _requestPermission(Permission.camera)) {
          throw Exception('Camera permission denied');
        }
      } else {
        if (!await _requestPermission(Permission.photos)) {
          throw Exception('Photos permission denied');
        }
      }

      // Pick image
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: maxWidth.toDouble(),
        maxHeight: maxHeight.toDouble(),
        imageQuality: quality,
      );

      if (image == null) return null;

      // Get app directory
      final Directory appDir = await getApplicationDocumentsDirectory();
      final String imagesDir = path.join(appDir.path, directory);

      // Create directory if it doesn't exist
      await Directory(imagesDir).create(recursive: true);

      // Generate unique filename
      final String fileName =
          '${prefix}_${DateTime.now().millisecondsSinceEpoch}${path.extension(image.path)}';
      final String savedPath = path.join(imagesDir, fileName);

      // Copy image to app directory
      await File(image.path).copy(savedPath);

      return savedPath;
    } catch (e) {
      debugPrint('Error picking/saving image: $e');
      return null;
    }
  }

  Future<void> deleteImage(String imagePath) async {
    try {
      final file = File(imagePath);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      debugPrint('Error deleting image: $e');
    }
  }

  Future<File?> getImage(String imagePath) async {
    try {
      final file = File(imagePath);
      if (await file.exists()) {
        return file;
      }
      return null;
    } catch (e) {
      debugPrint('Error getting image: $e');
      return null;
    }
  }
}
