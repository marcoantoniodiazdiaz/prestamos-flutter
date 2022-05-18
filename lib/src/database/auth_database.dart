import 'package:prestamos/src/database/database.dart';
import 'package:prestamos/src/database/preferences.dart';
import 'package:prestamos/src/models/login_model.dart';
import 'package:prestamos/src/utils/snackbars_utils.dart';

class AuthDatabase {
  static Future<bool> login(Map<String, dynamic> data) async {
    try {
      final resp = await DioInstance.dio.post('${DioInstance.server}/users/login', data: data);

      print(UserPreferences.token);

      final decodedResp = resp.data;
      if (decodedResp == null) return false;

      if (decodedResp['ok']) {
        // Autenticación correcta
        final credentials = LoginModel.fromJson(decodedResp['data']);
        UserPreferences.setId(credentials.user.id);
        UserPreferences.setName(credentials.user.name);
        UserPreferences.setEmail(credentials.user.email);
        UserPreferences.setPhoto(credentials.user.image);
        UserPreferences.setToken(credentials.token);
      }

      return decodedResp['ok'];
    } catch (e) {
      SnackBarUtils.snackBarError('Credenciales invalidas');
      return false;
    }
  }
}
