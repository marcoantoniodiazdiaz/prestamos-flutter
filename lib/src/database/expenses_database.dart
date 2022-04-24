import 'package:prestamos/src/database/dio_database.dart';
import 'package:prestamos/src/models/expenses_model.dart';

class ExpensesDatabase {
  static Future<List<ExpensesModel>> get() async {
    final resp = await DioInstance.get(
      '${DioInstance.server}/expenses',
    );

    final decodedResp = resp?.data;
    if (decodedResp == null) return [];
    if (decodedResp['data'] == null) return [];

    List<ExpensesModel> items = [];

    decodedResp['data'].forEach((x) {
      final temp = ExpensesModel.fromJson(x);
      items.add(temp);
    });

    return items;
  }

  static Future<bool> post(Map<String, dynamic> data) async {
    final resp = await DioInstance.post('${DioInstance.server}/expenses', data, onSuccess: 'Gasto guardado correctamente');

    final decodedResp = resp?.data;
    if (decodedResp == null) return false;

    return decodedResp['ok'];
  }

  static Future<bool> put(Map<String, dynamic> data) async {
    final resp = await DioInstance.dio.put('${DioInstance.server}/expenses', data: data);

    final decodedResp = resp.data;

    return decodedResp;
  }

  static Future<bool> delete(int id) async {
    final resp = await DioInstance.dio.delete('${DioInstance.server}/expenses/$id');

    final decodedResp = resp.data;

    return decodedResp;
  }
}
