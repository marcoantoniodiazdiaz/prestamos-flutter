import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class ProductsProvider with ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late String name, description;

  List<File> imagesTaken = [];

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  takeImage() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.camera);

    if (file == null) return;
    imagesTaken.add(File(file.path));

    notifyListeners();
  }

  removeImageFromList(File file) {
    imagesTaken.removeWhere((e) => e == file);
    notifyListeners();
  }
}
