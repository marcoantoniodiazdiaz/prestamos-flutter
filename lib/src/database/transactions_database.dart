import 'package:prestamos/src/database/dio_database.dart';
import 'package:prestamos/src/models/transactions_model.dart';

class TransactionsDatabase {
  static Future<List<TransactionsModel>> get() async {
    final resp = await DioInstance.get(
      '${DioInstance.server}/transactions',
    );

    final decodedResp = resp?.data;
    if (decodedResp == null) return [];
    if (decodedResp['data'] == null) return [];

    List<TransactionsModel> items = [];

    decodedResp['data'].forEach((x) {
      final temp = TransactionsModel.fromJson(x);
      items.add(temp);
    });

    return items;
  }

  static Future<bool> post(Map<String, dynamic> data) async {
    final resp = await DioInstance.dio.post('${DioInstance.server}/transactions', data: data);

    final decodedResp = resp.data;

    return decodedResp;
  }

  static Future<bool> put(Map<String, dynamic> data) async {
    final resp = await DioInstance.dio.put('${DioInstance.server}/transactions', data: data);

    final decodedResp = resp.data;

    return decodedResp;
  }

  static Future<bool> delete(int id) async {
    final resp = await DioInstance.dio.delete('${DioInstance.server}/transactions/$id');

    final decodedResp = resp.data;

    return decodedResp;
  }
}
