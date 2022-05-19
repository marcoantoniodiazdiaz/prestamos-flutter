import 'package:prestamos/src/database/database.dart';
import 'package:prestamos/src/models/settings_model.dart';

class SettingsDatabase {
  static Future<SettingsModel?> key(String key) async {
    final resp = await DioInstance.get(
      '${DioInstance.server}/settings/$key',
    );

    if (resp == null) return null;
    final decodedResp = resp.data;

    if (decodedResp['data'] == null) return null;

    return SettingsModel.fromJson(decodedResp['data']);
  }

  static Future<bool> post(Map<String, dynamic> data) async {
    final resp =
        await DioInstance.post('${DioInstance.server}/settings', data, onSuccess: 'Valor actualizado');

    final decodedResp = resp?.data;
    if (decodedResp == null) return false;

    return decodedResp['ok'];
  }
}
