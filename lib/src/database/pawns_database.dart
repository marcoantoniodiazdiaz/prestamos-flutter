import 'package:prestamos/src/database/dio_database.dart';
import 'package:prestamos/src/models/pawns_model.dart';

class PawnsDatabase {
  static Future<List<PawnsModel>> get() async {
    final resp = await DioInstance.dio.get(
      '${DioInstance.server}/pawns',
    );

    final decodedResp = resp.data;

    if (decodedResp['data'] == null) return [];

    List<PawnsModel> items = [];

    decodedResp['data'].forEach((x) {
      final temp = PawnsModel.fromJson(x);
      items.add(temp);
    });

    return items;
  }

  static Future<List<PawnsModel>> findByClient(int id) async {
    final resp = await DioInstance.dio.get(
      '${DioInstance.server}/pawns/client/$id',
    );

    final decodedResp = resp.data;

    if (decodedResp['data'] == null) return [];

    List<PawnsModel> items = [];

    decodedResp['data'].forEach((x) {
      final temp = PawnsModel.fromJson(x);
      items.add(temp);
    });

    return items;
  }

  static Future<PawnsModel?> fk(int id) async {
    final resp = await DioInstance.dio.get(
      '${DioInstance.server}/pawns/$id',
    );

    final decodedResp = resp.data;

    if (decodedResp['data'] == null) return null;

    return PawnsModel.fromJson(decodedResp['data']);
  }

  static Future<bool> post(Map<String, dynamic> data) async {
    final resp = await DioInstance.post('${DioInstance.server}/pawns', data, onSuccess: 'Asociación generada');

    final decodedResp = resp?.data;
    if (decodedResp == null) return false;

    return decodedResp['ok'];
  }

  static Future<bool> put(Map<String, dynamic> data) async {
    final resp = await DioInstance.dio.put('${DioInstance.server}/pawns', data: data);

    final decodedResp = resp.data;

    return decodedResp;
  }

  static Future<bool> delete(int id) async {
    final resp = await DioInstance.dio.delete('${DioInstance.server}/pawns/$id');

    final decodedResp = resp.data;

    return decodedResp;
  }
}
