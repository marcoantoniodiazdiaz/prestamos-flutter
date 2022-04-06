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
    final resp = await DioInstance.dio.post('${DioInstance.server}/clients', data: data);

    final decodedResp = resp.data;

    return decodedResp['ok'];
  }

  static Future<bool> put(Map<String, dynamic> data) async {
    final resp = await DioInstance.dio.put('${DioInstance.server}/clients', data: data);

    final decodedResp = resp.data;

    return decodedResp['ok'];
  }

  static Future<bool> delete(int id) async {
    final resp = await DioInstance.dio.delete('${DioInstance.server}/clients/$id');

    final decodedResp = resp.data;

    return decodedResp['ok'];
  }
}
