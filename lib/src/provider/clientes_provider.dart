import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prestamos/src/database/clients_database.dart';
import 'package:prestamos/src/models/clients_model.dart';
import 'package:prestamos/src/utils/snackbars_utils.dart';

class ClientesProvider extends ChangeNotifier {
  ClientesProvider() {
    reload();
  }

  final formKey = GlobalKey<FormState>();
  late String name, direction, city, email, comment;

  List<ClientsModel> _clients = [];
  List<ClientsModel> get clients => _clients;

  List<ClientsModel> _filtered = [];
  List<ClientsModel> get filtered => _filtered;

  late File _profileSelected;
  File get profileSelected => _profileSelected;
  set profileSelected(File i) {
    _profileSelected = i;
    notifyListeners();
  }

  reload() async {
    _clients = await ClientsDatabase.get();
    _filtered = _clients;
    notifyListeners();
  }

  findClient(String v) {
    if (v.isEmpty) return _clients;

    _filtered = _clients.where((e) {
      return e.name.toLowerCase().contains(v.toLowerCase());
    }).toList();
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  post() async {
    if (!isValidForm()) return false;

    final Map<String, dynamic> data = {
      'name': name,
      'direction': direction,
      'city': city,
      'email': email,
      'comment': comment,
      'image': '',
    };

    final resp = await ClientsDatabase.post(data);

    if (resp) {
      reload();
    }

    return resp;
  }
}
