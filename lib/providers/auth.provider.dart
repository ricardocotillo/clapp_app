import 'dart:convert';

import 'package:clapp/models/token.model.dart';
import 'package:clapp/models/user.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

class AuthProvider extends ChangeNotifier {
  User? user;
  Token? token;

  AuthProvider({
    this.token,
    this.user,
  });

  Future<void> saveToken(Token t) async {
    const storage = FlutterSecureStorage();
    await storage.write(
      key: 'token',
      value: jsonEncode(t),
    );
    token = t;
  }

  Future<void> saveUser(User u) async {
    await Hive.box<User>('me').put(0, u);
    user = u;
    notifyListeners();
  }

  bool get isAuthenticated => token != null;
  // bool get isAuthenticated => true;
}
