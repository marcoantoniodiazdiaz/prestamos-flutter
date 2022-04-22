import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:prestamos/src/utils/loading_utils.dart';
import 'package:prestamos/src/utils/snackbars_utils.dart';

class DioInstance {
  static final Dio dio = Dio(
    BaseOptions(
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      // headers: <String, dynamic>{
      //   'token': UserPreferences().token,
      // },
      // validateStatus: (code) {
      //   switch (code) {
      //     case 200:
      //       return true;
      //     case 401:
      //       SnackBarUtils.snackBarError('Carga de recurso denegada');
      //       return false;
      //     case 404:
      //       SnackBarUtils.snackBarError('Recurso no encontrado');
      //       return false;
      //     default:
      //       return true;
      //   }
      // },
    ),
  );

  static const String server = "http://192.168.0.15:7001/api";
  static const String sockets = "http://192.168.0.15:7001";
  // static final String server = "https://crowncleanapi.host/api";
  // static final String sockets = "http://45.80.152.52:8000/";

  static Future<Response<dynamic>?> get(String url) async {
    try {
      final resp = await DioInstance.dio.get(url);
      return resp;
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.connectTimeout) {
          SnackBarUtils.snackBarError('Tiempo de conexión agotado');
        } else if (e.type == DioErrorType.receiveTimeout) {
          SnackBarUtils.snackBarError('Tiempo de espera de petición agotado');
        } else if (e.type == DioErrorType.response) {
          if (e.response != null) {
            if (e.response?.statusCode == 404) {
              SnackBarUtils.snackBarError('Dirección de recurso no encontrada');
            } else {
              SnackBarUtils.snackBarError(e.response?.data['err']);
            }
          }
        }
      }
    }

    return null;
  }

  static Future<Response<dynamic>?> post(String url, Map<String, dynamic> data,
      {required String onSuccess}) async {
    try {
      LoadingUtils.showLoading();
      final resp = await DioInstance.dio.post(url, data: data);
      getx.Get.back(); // Request success, close loading

      if (resp.statusCode != 200) {
        if (resp.data['err'] != null) {
          SnackBarUtils.snackBarError(resp.data['err']);
        }
      } else {
        SnackBarUtils.snackBarSuccess(onSuccess);
      }

      return resp;
    } catch (e) {
      getx.Get.back(); // Request failed, close loading
      if (e is DioError) {
        if (e.type == DioErrorType.connectTimeout) {
          SnackBarUtils.snackBarError('Tiempo de conexión agotado');
        } else if (e.type == DioErrorType.receiveTimeout) {
          SnackBarUtils.snackBarError('Tiempo de espera de petición agotado');
        } else if (e.type == DioErrorType.response) {
          if (e.response != null) {
            try {
              SnackBarUtils.snackBarError(e.response?.data['err']);
            } catch (e) {
              SnackBarUtils.snackBarError('Error interno en el servidor');
            }
          }
        }
      }
    }

    return null;
  }
}
