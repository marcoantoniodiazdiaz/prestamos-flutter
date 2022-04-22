import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prestamos/src/database/clients_database.dart';
import 'package:prestamos/src/database/preferences.dart';
import 'package:prestamos/src/models/clients_model.dart';
import 'package:prestamos/src/utils/snackbars_utils.dart';

class ClientesProvider extends ChangeNotifier {
  ClientesProvider() {
    reload();
  }

  final formKey = GlobalKey<FormState>();
  final phoneFormKey = GlobalKey<FormState>();
  late String name, direction, city, email, comment;
  late String value;

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
    if (v.isEmpty) return _filtered = _clients;

    _filtered = _clients.where((e) {
      return e.name.toLowerCase().contains(v.toLowerCase());
    }).toList();
    notifyListeners();
  }

  bool isValidForm(GlobalKey<FormState> key) {
    return key.currentState?.validate() ?? false;
  }

  post() async {
    if (!isValidForm(formKey)) return false;

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

  addPhone() async {
    if (!isValidForm(phoneFormKey)) return false;

    final Map<String, dynamic> data = {
      'value': value,
      'type': 1,
      'clientId': UserPreferences.id,
    };

    final resp = await ClientsDatabase.addPhone(data);

    if (resp) {
      reload();
    }

    return resp;
  }
}
