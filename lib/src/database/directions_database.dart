import 'package:prestamos/src/database/database.dart';
import 'package:prestamos/src/models/directions_model.dart';

class DirectionsDatabase {
  static Future<List<DirectionsModel>> get(int clientId) async {
    final resp = await DioInstance.get(
      '${DioInstance.server}/directions/client/$clientId',
    );

    final decodedResp = resp?.data;

    if (decodedResp['data'] == null) return [];

    List<DirectionsModel> items = [];

    decodedResp['data'].forEach((x) {
      final temp = DirectionsModel.fromJson(x);
      items.add(temp);
    });

    return items;
  }

  static Future<bool> post(Map<String, dynamic> data) async {
    final resp = await DioInstance.post('${DioInstance.server}/directions', data, onSuccess: 'Dirección guardada correctamente');

    final decodedResp = resp?.data;
    if (decodedResp == null) return false;

    return decodedResp['ok'];
  }

  static Future<bool> delete(int directionId) async {
    final resp = await DioInstance.delete('${DioInstance.server}/directions/$directionId', onSuccess: 'Dirección eliminada correctamente');

    final decodedResp = resp?.data;
    if (decodedResp == null) return false;

    return decodedResp['ok'];
  }
}
