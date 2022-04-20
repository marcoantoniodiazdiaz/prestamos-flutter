import 'package:flutter/widgets.dart';
import 'package:prestamos/src/database/users_database.dart';
import 'package:prestamos/src/models/models.dart';

class UsersProvider extends ChangeNotifier {
  UsersProvider() {
    reload();
  }

  List<UsersModel> _users = [];
  List<UsersModel> get users => _users;

  reload() async {
    _users = await UsersDatabase.get();
    notifyListeners();
  }
}
