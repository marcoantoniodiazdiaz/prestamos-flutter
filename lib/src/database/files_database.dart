import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';

class FilesDatabase {
  static Future<String?> upload(File imagen) async {
    final cloudinary = CloudinaryPublic('dhxoolske', 'h8ivaaiq', cache: false);
    CloudinaryResponse response;
    try {
      response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(imagen.absolute.path, resourceType: CloudinaryResourceType.Image),
      );
      return response.secureUrl;
    } catch (e) {
      return null;
    }
  }
}
