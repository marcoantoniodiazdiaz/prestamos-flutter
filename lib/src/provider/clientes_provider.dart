import 'dart:io';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:prestamos/src/database/clients_database.dart';
import 'package:prestamos/src/design/designs.dart';
import 'package:prestamos/src/models/clients_model.dart';

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

  _showWhatsappRegister(int clientId) {
    showCupertinoModalBottomSheet(
      context: Get.context!,
      builder: (_) {
        return Material(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(
                  child: DesignTextButton(
                    width: double.infinity,
                    height: 45,
                    child: DesignText('Telefono/Fijo'),
                    color: DesignColors.green,
                    primary: Colors.white,
                    elevation: 2,
                    onPressed: () => _sendValueOfPhone(clientId, 0),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: DesignTextButton(
                    width: double.infinity,
                    height: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DesignText('Whatsapp'),
                        SizedBox(width: 10),
                        Icon(Icons.whatsapp),
                      ],
                    ),
                    color: Colors.white,
                    elevation: 2,
                    primary: Colors.green,
                    onPressed: () => _sendValueOfPhone(clientId, 1),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  addPhone({required int clientId}) async {
    if (!isValidForm(phoneFormKey)) return false;

    _showWhatsappRegister(clientId);
  }

  _sendValueOfPhone(int clientId, int type) async {
    final Map<String, dynamic> data = {
      'value': value,
      'type': type,
      'clientId': clientId,
    };

    final resp = await ClientsDatabase.addPhone(data);

    if (resp) {
      reload();
    }

    return resp;
  }
}
