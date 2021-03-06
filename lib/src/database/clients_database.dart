import 'package:prestamos/src/database/dio_database.dart';
import 'package:prestamos/src/models/clients_model.dart';

class ClientsDatabase {
  static Future<List<ClientsModel>> get() async {
    final resp = await DioInstance.get(
      '${DioInstance.server}/clients',
    );

    final decodedResp = resp?.data;

    if (decodedResp['data'] == null) return [];

    List<ClientsModel> items = [];

    decodedResp['data'].forEach((x) {
      final temp = ClientsModel.fromJson(x);
      items.add(temp);
    });

    return items;
  }

  static Future<ClientsModel?> fk(int id) async {
    final resp = await DioInstance.get(
      '${DioInstance.server}/clients/$id',
    );

    final decodedResp = resp?.data;

    if (decodedResp['data'] == null) return null;

    return ClientsModel.fromJson(decodedResp['data']);
  }

  static Future<bool> post(Map<String, dynamic> data) async {
    final resp = await DioInstance.post('${DioInstance.server}/clients', data, onSuccess: 'Cliente añadido de forma satistactoria');

    final decodedResp = resp?.data;
    if (decodedResp == null) return false;

    return decodedResp['ok'];
  }

  static Future<bool> put(Map<String, dynamic> data, int id) async {
    final resp = await DioInstance.put('${DioInstance.server}/clients/$id', data, onSuccess: 'Cliente actualizado de forma satistactoria');

    final decodedResp = resp?.data;
    if (decodedResp == null) return false;

    return decodedResp['ok'];
  }

  static Future<bool> addPhone(Map<String, dynamic> data) async {
    final resp = await DioInstance.post(
      '${DioInstance.server}/phones',
      data,
      onSuccess: 'Telefono registrado con exito',
    );

    final decodedResp = resp?.data;
    if (decodedResp == null) return false;

    return decodedResp['ok'];
  }

  static Future<bool> delete(int id) async {
    final resp = await DioInstance.dio.delete('${DioInstance.server}/clients/$id');

    final decodedResp = resp.data;

    return decodedResp['ok'];
  }
}
