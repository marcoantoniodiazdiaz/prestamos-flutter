import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prestamos/src/database/database.dart';
import 'package:prestamos/src/database/files_database.dart';
import 'package:prestamos/src/database/products_database.dart';
import 'package:prestamos/src/utils/loading_utils.dart';

class ProductsProvider with ChangeNotifier {
  ProductsProvider() {
    reload();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late String name, description;

  List<ProductsModel> _products = [];
  List<ProductsModel> get products => _products;

  List<ProductsModel> _available = [];
  List<ProductsModel> get available => _available;

  List<File> imagesTaken = [];

  reload() async {
    _products = await ProductsDatabase.get();
    _available = await ProductsDatabase.available();
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  takeImage() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.camera, imageQuality: 20);

    if (file == null) return;
    imagesTaken.add(File(file.path));

    notifyListeners();
  }

  removeImageFromList(File file) {
    imagesTaken.removeWhere((e) => e == file);
    notifyListeners();
  }

  post() async {
    if (!isValidForm() || imagesTaken.isEmpty) return;

    List<String> urls = [];

    LoadingUtils.showLoading(); // Loading de imagenes

    for (final e in imagesTaken) {
      final url = await FilesDatabase.upload(e);
      if (url != null) {
        urls.add(url);
      }
    }

    Get.back();

    final data = {
      'name': name,
      'description': description,
      'images': urls,
    };

    final resp = await ProductsDatabase.post(data);
    if (resp) {
      imagesTaken.clear();
      reload();
    }
  }
}
