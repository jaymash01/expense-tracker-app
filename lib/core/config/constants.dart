import 'package:flutter_dotenv/flutter_dotenv.dart';

final baseUrl = dotenv.env['BASE_URL'] ?? 'http://10.0.2.2:8000';

class Preferences {
  static const String themeMode = 'themeMode';
  static const String token = 'token';
}
