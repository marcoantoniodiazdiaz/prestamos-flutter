import 'package:prestamos/src/database/dio_database.dart';
import 'package:prestamos/src/models/permissions_model.dart';

class PermissionsDatabase {
  static Future<List<PermissionsModel>> get(int id) async {
    final resp = await DioInstance.get(
      '${DioInstance.server}/permissions/user/$id',
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

  static Future<bool> update(Map<String, dynamic> data) async {
    final resp = await DioInstance.post('${DioInstance.server}/actions/update', data,
        onSuccess: 'El permiso fue actualizado');
    if (resp == null) return false;
    final decodedResp = resp.data;

    return decodedResp['ok'];
  }
}
