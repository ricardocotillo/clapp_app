import 'package:clapp/models/filter.model.dart';
import 'package:clapp/models/page.model.dart';
import 'package:clapp/services/auth.service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class BaseService<T> {
  final String base = '/';
  final storage = const FlutterSecureStorage();
  final authService = AuthService();

  Future<T> get(int id);

  Future<BasePage> list({Filter? filter});

  Future<T> create(T model);

  // Future<T> update(T model);

  // Future<void> delete(int model);

  Future<Map<String, String>> get headers async {
    var h = {
      'Content-Type': 'application/json',
    };
    final t = await authService.getToken();
    if (t != null) h['Authorization'] = 'Bearer ${t.access}';
    return h;
  }

  Future<Map<String, String>> get authHeaders async {
    final t = await authService.getToken();
    Map<String, String> h = {};
    if (t != null) h['Authorization'] = 'Bearer ${t.access}';
    return h;
  }
}
