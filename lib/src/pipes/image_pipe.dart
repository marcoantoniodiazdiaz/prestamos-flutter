import 'package:flutter/material.dart';

class ImagePipes {
  static ImageProvider<Object> assetOrNetwork({String? url}) {
    // assert(url == null, 'La imagen es nula');
    try {
      if (url == null || url.isEmpty) {
        return AssetImage('assets/img/no-image.png');
      } else {
        return NetworkImage(url);
      }
    } catch (e) {
      return AssetImage('assets/img/no-image.png');
    }
  }
}
