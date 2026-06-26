import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService {
  static final LocalStorageService _instance = LocalStorageService._internal();
  factory LocalStorageService() => _instance;
  LocalStorageService._internal();
  late Box _subBox;
  late Box _authBox;
  Future<void> init() async {
    _subBox = await Hive.openBox('subBox');
    _authBox = await Hive.openBox('authBox');
  }
  Future<void> saveUser(String phone, String pass) async {
    await _authBox.put('phone', phone);
    await _authBox.put('pass', pass);
    await _authBox.put('isAuth', true);
  }
  Future<void> setAuth(bool val) async {
    await _authBox.put('isAuth', val);
  }
  bool isAuth() {
    return _authBox.get('isAuth', defaultValue: false);
  }
  String? getPhone() {
    return _authBox.get('phone');}

  String? getPass() {
    return _authBox.get('pass');}

  Future<void> logout() async {
    await _authBox.put('isAuth', false);}

  Future<void> saveSub({
    required String queId,
    required String queTitle,
    required Map<String, String> ans,
    required double lat,
    required double lng,
  }) async {
    final sub = {
      'queId': queId,
      'queTitle': queTitle,
      'ans': ans,
      'lat': lat,
      'lng': lng,
      'date': DateTime.now().toIso8601String(),
      'phone': getPhone() ?? 'anon',
    };

    List<dynamic> subs = _subBox.get('list', defaultValue: []);
    subs.add(sub);
    await _subBox.put('list', subs);
  }

  List<Map<String, dynamic>> getSubs() {
    List<dynamic> data = _subBox.get('list', defaultValue: []);
    return data.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  List<Map<String, dynamic>> getUserSubs() {
    final phone = getPhone();
    final all = getSubs();
    return all.where((e) => e['phone'] == phone).toList();
  }
}
