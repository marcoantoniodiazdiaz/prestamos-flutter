import 'package:prestamos/src/database/database.dart';

class ProductsDatabase {
  static Future<List<ProductsModel>> get() async {
    final resp = await DioInstance.get(
      '${DioInstance.server}/products',
    );

    final decodedResp = resp?.data;
    if (decodedResp == null) return [];
    if (decodedResp['data'] == null) return [];

    List<ProductsModel> items = [];

    decodedResp['data'].forEach((x) {
      final temp = ProductsModel.fromJson(x);
      items.add(temp);
    });

    return items;
  }

  static Future<List<ProductsModel>> available() async {
    final resp = await DioInstance.get(
      '${DioInstance.server}/products/available',
    );

    final decodedResp = resp?.data;
    if (decodedResp == null) return [];
    if (decodedResp['data'] == null) return [];

    List<ProductsModel> items = [];

    decodedResp['data'].forEach((x) {
      final temp = ProductsModel.fromJson(x);
      items.add(temp);
    });

    return items;
  }

  static Future<ProductsModel?> fk(int id) async {
    final resp = await DioInstance.dio.get(
      '${DioInstance.server}/products/$id',
    );

    final decodedResp = resp.data;

    if (decodedResp['data'] == null) return null;

    return ProductsModel.fromJson(decodedResp['data']);
  }

  static Future<bool> post(Map<String, dynamic> data) async {
    final resp = await DioInstance.post('${DioInstance.server}/products', data, onSuccess: 'Producto guardado con exito');

    final decodedResp = resp?.data;
    if (decodedResp == null) return false;

    return decodedResp['ok'];
  }

  static Future<bool> put(Map<String, dynamic> data) async {
    final resp = await DioInstance.dio.put('${DioInstance.server}/products', data: data);

    final decodedResp = resp.data;
    if (decodedResp == null) return false;

    return decodedResp;
  }

  static Future<bool> delete(int id) async {
    final resp = await DioInstance.dio.delete('${DioInstance.server}/products/$id');

    final decodedResp = resp.data;

    return decodedResp;
  }
}
