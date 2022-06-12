import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:prestamos/src/database/clients_database.dart';
import 'package:prestamos/src/database/files_database.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prestamos/src/design/designs.dart';
import 'package:prestamos/src/models/clients_model.dart';
import 'package:prestamos/src/utils/loading_utils.dart';
import 'package:path/path.dart';
import 'package:prestamos/src/views/clientes/nuevo_cliente_view.dart';
import 'package:http/http.dart' as http;

class ClientesProvider extends ChangeNotifier {
  ClientesProvider() {
    reload();
  }

  final formKey = GlobalKey<FormState>();
  final phoneFormKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController direction = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController comment = TextEditingController();
  late String value;

  List<ClientsModel> _clients = [];
  List<ClientsModel> get clients => _clients;

  List<ClientsModel> _filtered = [];
  List<ClientsModel> get filtered => _filtered;

  File? _profileSelected;
  File? get profileSelected => _profileSelected;
  set profileSelected(File? i) {
    _profileSelected = i;
    notifyListeners();
  }

  ClientsModel? _editing;
  ClientsModel? get editing => _editing;

  reload() async {
    _clients = await ClientsDatabase.get();
    _filtered = _clients;
    notifyListeners();
  }

  findClient(String v) {
    if (v.isEmpty) {
      _filtered = _clients;
      return notifyListeners();
    }

    _filtered = _clients.where((e) {
      return e.name.toLowerCase().contains(v.toLowerCase());
    }).toList();
    notifyListeners();
  }

  bool isValidForm(GlobalKey<FormState> key) {
    return key.currentState?.validate() ?? false;
  }

  setEditing(ClientsModel model) async {
    name.text = model.name;
    email.text = model.email;
    comment.text = model.comment ?? '';

    if (model.image.isNotEmpty) {
      LoadingUtils.showLoading();
      final response = await http.get(Uri.parse(model.image));
      Get.back();
      final documentDirectory = await getTemporaryDirectory();
      final file = File(join(documentDirectory.path, '${model.id}.jpg'));
      file.writeAsBytesSync(response.bodyBytes);

      _profileSelected = file;
    }

    _editing = model;
    notifyListeners();

    Get.to(() => NuevoClienteView());
  }

  clean() {
    name.text = '';
    email.text = '';
    comment.text = '';
    _profileSelected = null;
    _editing = null;
    notifyListeners();
  }

  post() async {
    if (!isValidForm(formKey)) return false;

    String? url;
    if (profileSelected != null) {
      LoadingUtils.showLoading();
      final cloudinary = await FilesDatabase.upload(profileSelected!);
      url = cloudinary;
      Get.back();
    }

    final Map<String, dynamic> data = {
      'name': name.text,
      'direction': 'x',
      'city': 'x',
      'email': email.text,
      'comment': comment.text,
      'image': url ?? '',
    };

    bool resp;
    if (_editing == null) {
      resp = await ClientsDatabase.post(data);
    } else {
      resp = await ClientsDatabase.put(data, editing!.id);
    }

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
                    color: DesignColors.orange,
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
