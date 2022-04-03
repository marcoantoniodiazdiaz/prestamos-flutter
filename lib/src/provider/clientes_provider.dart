import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prestamos/src/database/clients_database.dart';
import 'package:prestamos/src/models/clients_model.dart';
import 'package:prestamos/src/utils/snackbars_utils.dart';

class ClientesProvider extends ChangeNotifier {
  ClientesProvider() {
    reload();
  }

  List<ClientsModel> _clients = [];
  List<ClientsModel> get clients => _clients;

  late File _profileSelected;
  File get profileSelected => _profileSelected;
  set profileSelected(File i) {
    _profileSelected = i;
    notifyListeners();
  }

  reload() async {
    _clients = await ClientsDatabase.get();
    notifyListeners();
  }

  post(Map<String, dynamic> data) async {
    final resp = await ClientsDatabase.post(data);

    if (resp) {
      SnackBarUtils.snackBarSuccess('Cliente añadido de forma satisfactoria');
      reload();
    } else {
      SnackBarUtils.snackBarError('Ocurrio un error al realizar la acción');
    }
  }
}
