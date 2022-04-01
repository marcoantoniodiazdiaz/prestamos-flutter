import 'package:prestamos/src/database/dio_database.dart';
import 'package:prestamos/src/models/loans_model.dart';

class LoansDatabase {
  static Future<List<LoansModel>> get() async {
    final resp = await DioInstance.dio.get(
      '${DioInstance.server}/loans',
    );

    final decodedResp = resp.data;

    if (decodedResp['data'] == null) return [];

    List<LoansModel> items = [];

    decodedResp['data'].forEach((x) {
      final temp = LoansModel.fromJson(x);
      items.add(temp);
    });

    return items;
  }

  static Future<List<LoansModel>> findByClient(int id) async {
    final resp = await DioInstance.dio.get(
      '${DioInstance.server}/loans/client/$id',
    );

    final decodedResp = resp.data;

    if (decodedResp['data'] == null) return [];

    List<LoansModel> items = [];

    decodedResp['data'].forEach((x) {
      final temp = LoansModel.fromJson(x);
      items.add(temp);
    });

    return items;
  }

  static Future<LoansModel?> fk(int id) async {
    final resp = await DioInstance.dio.get(
      '${DioInstance.server}/loans/$id',
    );

    final decodedResp = resp.data;

    if (decodedResp['data'] == null) return null;

    return LoansModel.fromJson(decodedResp['data']);
  }

  static Future<bool> post(Map<String, dynamic> data) async {
    final resp = await DioInstance.dio.post('${DioInstance.server}/loans', data: data);

    final decodedResp = resp.data;

    return decodedResp;
  }

  static Future<bool> put(Map<String, dynamic> data) async {
    final resp = await DioInstance.dio.put('${DioInstance.server}/loans', data: data);

    final decodedResp = resp.data;

    return decodedResp;
  }

  static Future<bool> delete(int id) async {
    final resp = await DioInstance.dio.delete('${DioInstance.server}/loans/$id');

    final decodedResp = resp.data;

    return decodedResp;
  }
}
