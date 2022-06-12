import 'package:prestamos/src/database/dio_database.dart';
import 'package:prestamos/src/models/amount_pay_model.dart';
import 'package:prestamos/src/models/payments_model.dart';

class PaymentsDatabase {
  static Future<List<PaymentsModel>> get() async {
    final resp = await DioInstance.dio.get(
      '${DioInstance.server}/payments',
    );

    final decodedResp = resp.data;

    if (decodedResp['data'] == null) return [];

    List<PaymentsModel> items = [];

    decodedResp['data'].forEach((x) {
      final temp = PaymentsModel.fromJson(x);
      items.add(temp);
    });

    return items;
  }

  static Future<PaymentsModel?> fk(int id) async {
    final resp = await DioInstance.dio.get(
      '${DioInstance.server}/payments/$id',
    );

    final decodedResp = resp.data;

    if (decodedResp['data'] == null) return null;

    return PaymentsModel.fromJson(decodedResp['data']);
  }

  static Future<AmountToPayModel?> amountToPay(int loanId) async {
    final resp = await DioInstance.get(
      '${DioInstance.server}/loans/get-payment/$loanId',
    );

    if (resp == null) return null;
    final decodedResp = resp.data;

    if (decodedResp['data'] == null) return null;

    return AmountToPayModel.fromJson(decodedResp['data']);
  }

  static Future<bool> post(Map<String, dynamic> data) async {
    final resp = await DioInstance.post('${DioInstance.server}/payments', data, onSuccess: 'Pago registrado con exito');

    final decodedResp = resp?.data;

    return decodedResp['ok'];
  }

  static Future<bool> put(Map<String, dynamic> data) async {
    final resp = await DioInstance.dio.put('${DioInstance.server}/payments', data: data);

    final decodedResp = resp.data;

    return decodedResp;
  }

  static Future<bool> delete(int id) async {
    final resp = await DioInstance.dio.delete('${DioInstance.server}/payments/$id');

    final decodedResp = resp.data;

    return decodedResp;
  }
}
