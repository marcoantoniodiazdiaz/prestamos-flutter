import 'package:prestamos/src/database/database.dart';
import 'package:prestamos/src/models/stadistics_model.dart';

class StadisticsDatabase {
  static Future<StadisticsModel?> get() async {
    final resp = await DioInstance.dio.get(
      '${DioInstance.server}/statistics/all',
    );

    final decodedResp = resp.data;

    if (decodedResp['data'] == null) return null;

    return StadisticsModel.fromJson(decodedResp['data']);
  }
}
