import 'dart:convert';
import 'dart:io';

import 'package:starter/features/auth/model/auth_token.dart';
import 'package:starter/features/profile/model/user.dart';

class AuthMockModels {
  static dynamic getJsonFromFile(String fileName) {
    const basePath = 'test/auth/assets';
    final jsonString = File('$basePath/$fileName').readAsStringSync();

    return json.decode(jsonString);
  }

  static Map<String, dynamic> get rawToken =>
      getJsonFromFile('token.json') as Map<String, dynamic>;

  static Map<String, dynamic> get rawUser =>
      getJsonFromFile('user.json') as Map<String, dynamic>;

  static AuthToken get authToken => AuthToken.fromJson(rawToken);

  static User get user => User.fromJson(rawUser);
}
