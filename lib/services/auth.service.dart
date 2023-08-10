import 'dart:async';
import 'dart:convert';

import 'package:clapp/config.dart';
import 'package:clapp/models/token.model.dart';
import 'package:clapp/models/user.model.dart';
import 'package:clapp/providers/login.provider.dart';
import 'package:clapp/providers/register.provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String base = '${Config.domain}/auth';
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  Future<Map<String, String>> get authenticatedHeaders async {
    var h = {
      'Content-Type': 'application/json',
    };
    final t = await getToken();
    if (t != null) h['Authorization'] = 'Bearer ${t.access}';
    return h;
  }

  Future<Token?> login(LoginProvider login) async {
    final Uri url = Uri.parse('$base/jwt/create/');
    final res = await http.post(
      url,
      headers: headers,
      body: jsonEncode(login),
    );
    if (res.statusCode == 400) throw res.body;
    if (res.statusCode == 401) {
      throw '{"error": "Email o Contraseña incorrecta"}';
    }
    final j = jsonDecode(res.body);
    return Token.fromJson(j);
  }

  Future<User?> register(RegisterProvider register) async {
    final Uri url = Uri.parse('$base/users/');

    final res = await http.post(
      url,
      body: jsonEncode(register),
      headers: headers,
    );
    if (res.statusCode >= 400) throw res.body;
    final j = jsonDecode(res.body);
    return User.fromJson(j);
  }

  Future<User> me() async {
    final uri = Uri.parse('$base/users/me/');
    final res = await http.get(
      uri,
      headers: await authenticatedHeaders,
    );
    final j = jsonDecode(utf8.decode(res.bodyBytes));
    return User.fromJson(j);
  }

  Future<User> profile(User user) async {
    final uri = Uri.parse('$base/users/me/');
    final res = await http.post(
      uri,
      body: jsonEncode(user),
      headers: await authenticatedHeaders,
    );
    final j = jsonDecode(utf8.decode(res.bodyBytes));
    return User.fromJson(j);
  }

  Future<Token?> getToken() async {
    const storage = FlutterSecureStorage();
    final s = await storage.read(key: 'token');
    var token = s != null ? Token.fromJson(jsonDecode(s)) : null;
    if (token != null) {
      final ok = await verify(token);
      if (!ok) {
        token = await refresh(token);
        await storage.write(
          key: 'token',
          value: jsonEncode(token),
        );
      }
    }
    return token;
  }

  Future<bool> verify(Token token) async {
    final Uri url = Uri.parse('$base/jwt/verify/');
    final res = await http.post(
      url,
      headers: headers,
      body: jsonEncode({
        'token': token.access,
      }),
    );
    return res.statusCode == 200;
  }

  Future<Token> refresh(Token token) async {
    final Uri url = Uri.parse('$base/jwt/refresh/');
    final res = await http.post(
      url,
      headers: headers,
      body: jsonEncode(token),
    );
    final j = jsonDecode(res.body);
    return Token(access: j['access'], refresh: token.refresh);
  }
}
