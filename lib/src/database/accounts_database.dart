import 'package:prestamos/src/database/dio_database.dart';
import 'package:prestamos/src/models/accounts_model.dart';

class AccountsDatabase {
  static Future<List<AccountsModel>> get() async {
    final resp = await DioInstance.dio.get(
      '${DioInstance.server}/accounts',
    );

    final decodedResp = resp.data;

    if (decodedResp['data'] == null) return [];

    List<AccountsModel> items = [];

    decodedResp['data'].forEach((x) {
      final temp = AccountsModel.fromJson(x);
      items.add(temp);
    });

    return items;
  }

  static Future<bool> post(Map<String, dynamic> data) async {
    final resp = await DioInstance.dio.post('${DioInstance.server}/accounts', data: data);

    final decodedResp = resp.data;

    return decodedResp;
  }

  static Future<bool> put(Map<String, dynamic> data) async {
    final resp = await DioInstance.dio.put('${DioInstance.server}/accounts', data: data);

    final decodedResp = resp.data;

    return decodedResp;
  }

  static Future<bool> delete(int id) async {
    final resp = await DioInstance.dio.delete('${DioInstance.server}/accounts/$id');

    final decodedResp = resp.data;

    return decodedResp;
  }
}
