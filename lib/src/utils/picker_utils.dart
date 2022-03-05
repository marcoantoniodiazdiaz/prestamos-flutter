import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class PickerUtils {
  static Future<XFile?> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image;

    // if (image != null) {
    //   print(image.path);
    // }
    await showCupertinoModalBottomSheet(
      context: Get.context!,
      builder: (_) {
        return Material(
          child: Container(
            padding: EdgeInsets.all(10),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: IconButton(
                      onPressed: () async {
                        await _picker.pickImage(source: ImageSource.camera);
                      },
                      icon: Icon(FeatherIcons.camera, size: 30),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () async {
                        await _picker.pickImage(source: ImageSource.gallery);
                      },
                      icon: Icon(FeatherIcons.archive, size: 30),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    return image;
  }
}
