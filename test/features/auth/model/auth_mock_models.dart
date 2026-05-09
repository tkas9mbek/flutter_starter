import 'dart:convert';
import 'dart:io';

import 'package:starter/features/auth/model/auth_token.dart';
import 'package:starter/features/profile/model/user.dart';

class AuthMockModels {
  static dynamic _getJsonFromFile(String fileName) {
    const basePath = 'test/features/auth/assets';
    final jsonString = File('$basePath/$fileName').readAsStringSync();

    return json.decode(jsonString);
  }

  static final Map<String, dynamic> _rawToken =
      _getJsonFromFile('token.json') as Map<String, dynamic>;
  static final Map<String, dynamic> _rawUser =
      _getJsonFromFile('user.json') as Map<String, dynamic>;

  static final AuthToken _authToken = AuthToken.fromJson(_rawToken);
  static final User _user = User.fromJson(_rawUser);

  static Map<String, dynamic> get rawToken =>
      Map<String, dynamic>.from(_rawToken);

  static Map<String, dynamic> get rawUser =>
      Map<String, dynamic>.from(_rawUser);

  static AuthToken get authToken => _authToken;

  static User get user => _user;
}
