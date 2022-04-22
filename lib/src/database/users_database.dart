import 'package:prestamos/src/database/dio_database.dart';
import 'package:prestamos/src/models/models.dart';

class UsersDatabase {
  static Future<List<UsersModel>> get() async {
    final resp = await DioInstance.get(
      '${DioInstance.server}/users',
    );

    final decodedResp = resp?.data;
    if (decodedResp == null) return [];

    List<UsersModel> items = [];

    decodedResp['data'].forEach((x) {
      final temp = UsersModel.fromJson(x);
      items.add(temp);
    });

    return items;
  }

  static Future<UsersModel?> fk(int id) async {
    final resp = await DioInstance.dio.get(
      '${DioInstance.server}/users/$id',
    );

    final decodedResp = resp.data;

    if (decodedResp['data'] == null) return null;

    return UsersModel.fromJson(decodedResp['data']);
  }

  static Future<bool> post(Map<String, dynamic> data) async {
    final resp =
        await DioInstance.post('${DioInstance.server}/users', data, onSuccess: 'Empleado guardado con exito');

    final decodedResp = resp?.data;
    if (decodedResp == null) return false;

    return decodedResp['ok'];
  }

  static Future<bool> put(Map<String, dynamic> data) async {
    final resp = await DioInstance.dio.put('${DioInstance.server}/users', data: data);

    final decodedResp = resp.data;

    return decodedResp;
  }

  static Future<bool> delete(int id) async {
    final resp = await DioInstance.dio.delete('${DioInstance.server}/users/$id');

    final decodedResp = resp.data;

    return decodedResp;
  }
}
