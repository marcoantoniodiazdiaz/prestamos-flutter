import 'package:prestamos/src/database/database.dart';
import 'package:prestamos/src/models/moras_model.dart';

class MorasDatabase {
  static Future<List<MorasModel>> get() async {
    final resp = await DioInstance.get(
      '${DioInstance.server}/moras',
    );

    if (resp == null) return [];
    final decodedResp = resp.data;

    if (decodedResp['data'] == null) return [];

    List<MorasModel> items = [];

    decodedResp['data'].forEach((x) {
      final temp = MorasModel.fromJson(x);
      items.add(temp);
    });

    return items;
  }
}
