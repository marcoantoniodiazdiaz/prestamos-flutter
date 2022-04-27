import 'package:flutter/widgets.dart';
import 'package:prestamos/src/database/database.dart';

class EmpenosProvider with ChangeNotifier {
  ClientsModel? _client;
  ClientsModel? get client => _client;
  set client(ClientsModel? client) {
    if (client == null) {
      _loan = null;
      _product = null;
      _loans = [];
    }

    _client = client;
    notifyListeners();
  }

  LoansModel? _loan;
  LoansModel? get loan => _loan;
  set loan(LoansModel? loan) {
    _loan = loan;
    notifyListeners();
  }

  ProductsModel? _product;
  ProductsModel? get product => _product;
  set product(ProductsModel? product) {
    _product = product;
    notifyListeners();
  }

  late bool _showClientList;
  bool get showClientList => _showClientList;
  set showClientList(bool showClientList) {
    _showClientList = showClientList;
    notifyListeners();
  }

  List<LoansModel> _loans = [];
  List<LoansModel> get loans => _loans;

  getLoansOfClient() async {
    final resp = await LoansDatabase.findByClient(client!.id);
    _loans = resp;
    notifyListeners();
  }

  bool showButton() => _client != null && _loan != null && _product != null;

  post() async {
    final data = {
      'productId': product!.id,
      'loanId': loan!.id,
    };

    final resp = await PawnsDatabase.post(data);
    if (resp) {}
  }
}
