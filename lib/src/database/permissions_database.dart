import 'package:prestamos/src/database/dio_database.dart';
import 'package:prestamos/src/models/permissions_model.dart';

class PermissionsDatabase {
  static Future<List<PermissionsModel>> get() async {
    final resp = await DioInstance.get(
      '${DioInstance.server}/permissions',
    );

    if (resp == null) return [];
    final decodedResp = resp.data;

    if (decodedResp['data'] == null) return [];

    List<PermissionsModel> items = [];

    decodedResp['data'].forEach((x) {
      final temp = PermissionsModel.fromJson(x);
      items.add(temp);
    });

    return items;
  }

  static Future<PermissionsModel?> fk(int id) async {
    final resp = await DioInstance.dio.get(
      '${DioInstance.server}/permissions/$id',
    );

    final decodedResp = resp.data;

    if (decodedResp['data'] == null) return null;

    return PermissionsModel.fromJson(decodedResp['data']);
  }

  static Future<bool> post(Map<String, dynamic> data) async {
    final resp = await DioInstance.dio.post('${DioInstance.server}/permissions', data: data);

    final decodedResp = resp.data;

    return decodedResp;
  }

  static Future<bool> put(Map<String, dynamic> data) async {
    final resp = await DioInstance.dio.put('${DioInstance.server}/permissions', data: data);

    final decodedResp = resp.data;

    return decodedResp;
  }

  static Future<bool> delete(int id) async {
    final resp = await DioInstance.dio.delete('${DioInstance.server}/permissions/$id');

    final decodedResp = resp.data;

    return decodedResp;
  }
}
