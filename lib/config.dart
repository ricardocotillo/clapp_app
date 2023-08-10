import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static String domain = dotenv.env['DOMAIN'] ?? 'http://10.0.2.2:5000';
  static String base = '$domain/api';
}
