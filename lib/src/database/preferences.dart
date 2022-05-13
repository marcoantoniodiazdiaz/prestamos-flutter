import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instancia = UserPreferences._internal();

  factory UserPreferences() {
    return _instancia;
  }

  UserPreferences._internal();

  static SharedPreferences? _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static get name {
    return _prefs?.get('name') ?? '';
  }

  static void setName(String name) {
    _prefs?.setString('name', name);
  }

  static get email {
    return _prefs?.get('email') ?? '';
  }

  static void setEmail(String email) {
    _prefs?.setString('email', email);
  }

  static get photo {
    return _prefs?.get('photo') ?? '';
  }

  static void setPhoto(String photo) {
    _prefs?.setString('photo', photo);
  }

  static get phone {
    return _prefs?.get('phone') ?? '';
  }

  static void setPhone(String phone) {
    _prefs?.setString('phone', phone);
  }

  static get token {
    return _prefs?.get('token') ?? '';
  }

  static void setToken(String token) {
    _prefs?.setString('token', token);
  }

  static get id {
    return _prefs?.get('id') ?? '';
  }

  static void setId(int id) {
    _prefs?.setInt('id', id);
  }

  static get fcm {
    return _prefs?.get('fcm') ?? '';
  }

  static void setFCM(String fcm) {
    _prefs?.setString('fcm', fcm);
  }

  static get permissions {
    return _prefs?.getStringList('permissions') ?? [];
  }

  static getIntPermissions() {
    if (_prefs?.getStringList('permissions') == null) return [];
    return _prefs?.getStringList('permissions')?.map((e) => int.parse(e)) ?? [];
  }

  static void setPermissions(List<String> permissions) {
    _prefs?.setStringList('permissions', permissions);
  }
}
