import 'package:dio/dio.dart';
import 'package:prestamos/src/utils/snackbars_utils.dart';

class DioInstance {
  static final Dio dio = Dio(
    BaseOptions(
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      // headers: <String, dynamic>{
      //   'token': UserPreferences().token,
      // },
      validateStatus: (code) {
        switch (code) {
          case 200:
            return true;
          case 401:
            SnackBarUtils.snackBarError('Carga de recurso denegada');
            return false;
          case 404:
            SnackBarUtils.snackBarError('Recurso no encontrado');
            return false;
          default:
            return true;
        }
      },
    ),
  );

  static const String server = "http://192.168.0.11:7000/api";
  static const String sockets = "http://192.168.0.11:7000";
  // static final String server = "https://crowncleanapi.host/api";
  // static final String sockets = "http://45.80.152.52:8000/";
}
